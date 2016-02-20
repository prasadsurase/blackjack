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
  belongs_to :user #player
  belongs_to :admin, -> { where admin: true }, class_name: 'User', foreign_key: :admin_id #dealter
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id, optional: true

  has_many :steps
  has_many :game_decks #decks assinged to this game. default is 6
  has_many :decks, through: :game_decks
  has_many :cards, through: :decks

  validates :user, :admin, presence: true
  validates :bet, numericality: { only_integer: true, greater_than: 0 }, presence: true

  enum winning_type: [:majority, :blackjack] #method of winning, either :majority or :blackjack

  scope :finished, -> { where.not(winner_id: nil) } #finished games are displayed on the games page
  scope :ongoing, -> { where(winner_id: nil) }

  #first step is 'Game start'
  after_create :create_first_step

  #we dont create seperate deck for every game. we game M-M deck. we create the third table entries
  after_create :associate_game_decks

  #last step is 'Game over'
  after_update :create_last_step

  #if winner is assigned, then update dealer's and player's game stats.
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

  #decide the winner depending upon the user's points
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
    # if winner is present then update the winner's game stats
    if winner
      winner.blackjack?(self) ? winner.increment!(:blackjacks, 1) : winner.increment!(:majorities, 1)
      #find the loser and update his game stats
      loser = winner.admin? ? user : admin
      loser.increment!(:busts, 1)
    end
  end
end
