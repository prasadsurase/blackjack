class Game < ApplicationRecord
  belongs_to :user
  belongs_to :admin, -> { where admin: true }, class_name: 'User', foreign_key: :admin_id

  has_many :game_decks
  has_many :decks, through: :game_decks
  has_many :cards, through: :decks

  validates :user, :admin, presence: true
  validates :bet, numericality: { only_integer: true, greater_than: 0 }, presence: true

  after_create :associate_game_decks

  private

  def associate_game_decks
    Deck.all.each{|deck| self.game_decks.create(deck: deck)}
    cards.sample(2).each do |card|
      user.game_cards.create!(game: self, card: card)
    end

    admin.game_cards.create!(game: self, card: cards.sample)
  end
end
