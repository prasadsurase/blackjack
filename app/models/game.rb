# == Schema Information
#
# Table name: games
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  bet          :integer          not null
#  admin_id     :integer          not null
#  winner_id    :integer
#  winning_type :integer          default("majority")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Game < ApplicationRecord
  belongs_to :user
  belongs_to :admin, -> { where admin: true }, class_name: 'User', foreign_key: :admin_id
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id, optional: true

  has_many :steps
  has_many :game_decks
  has_many :decks, through: :game_decks
  has_many :cards, through: :decks

  validates :user, :admin, presence: true
  validates :bet, numericality: { only_integer: true, greater_than: 0 }, presence: true

  enum winning_type: [:majority, :blackjack]

  scope :finished, -> { where.not(winner_id: nil) }
  scope :ongoing, -> { where(winner_id: nil) }

  after_create :create_first_step
  after_create :associate_game_decks
  after_update :create_last_step
  after_update :update_user_game_stats

  def hit
    self.steps.create!(kind: :hit)
    user.game_cards.create!(game: self, card: cards.sample)
    update_winner
  end

  def stand
    self.steps.create!(kind: :stand)
    loop do
      gc = admin.game_cards.create!(game: self, card: cards.sample)
      winner = if admin.blackjack?(self)
                 admin
               elsif admin.bust?(self)
                 user
               elsif admin.current_points(self) >= 17
                 admin.current_points(self) > user.current_points(self) ? admin : user
               end

      self.update({winner: winner}) and break if winner
    end
  end

  private

  def associate_game_decks
    Deck.all.each{|deck| self.game_decks.create(deck: deck)}
    cards.sample(2).each do |card|
      user.game_cards.create!(game: self, card: card)
    end

    admin.game_cards.create!(game: self, card: cards.sample)
    update_winner
  end

  def update_winner
    winner = if user.blackjack?(self)
               user
             elsif user.bust?(self)
               admin
             end
    self.update({winner: winner}) if winner
  end

  def create_first_step
    self.steps.create!(kind: :game_start)
  end

  def create_last_step
    self.steps.create!(kind: :game_over) if winner
  end

  def update_user_game_stats
    if winner
      winner.blackjack?(self) ? winner.increment!(:blackjacks, 1) : winner.increment!(:majorities, 1)
      loser = winner.admin? ? user : admin
      loser.increment!(:busts, 1)
    end
  end
end
