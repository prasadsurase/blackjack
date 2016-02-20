class Game < ApplicationRecord
  belongs_to :user
  belongs_to :admin, -> { where admin: true }, class_name: 'User', foreign_key: :admin_id
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id, optional: true

  has_many :game_decks
  has_many :decks, through: :game_decks
  has_many :cards, through: :decks

  validates :user, :admin, presence: true
  validates :bet, numericality: { only_integer: true, greater_than: 0 }, presence: true

  scope :finished, -> { where.not(winner_id: nil) }
  scope :ongoing, -> { where(winner_id: nil) }

  after_create :associate_game_decks

  def hit
    user.game_cards.create!(game: self, card: cards.sample)
    winner = if user.blackjack?(self)
               user
             elsif user.bust?(self)
               admin
             end
    self.update({winner: winner}) if winner
  end

  def stand
    loop do
      admin.game_cards.create!(game: self, card: cards.sample)
      winner = if admin.blackjack?(self)
                 admin
               elsif admin.bust?(self)
                 user
               elsif admin.current_points(self) >= 17
                 admin.current_points(self) > user.current_points(self) ? admin : user
               end

      self.update({winner: winner}) and break if winner
      #break if admin.current_points(self) >= 17
    end
  end

  private

  def associate_game_decks
    Deck.all.each{|deck| self.game_decks.create(deck: deck)}
    cards.sample(2).each do |card|
      user.game_cards.create!(game: self, card: card)
    end

    admin.game_cards.create!(game: self, card: cards.sample)
  end
end
