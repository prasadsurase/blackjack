class Deck < ApplicationRecord
  has_many :deck_cards
  has_many :cards, through: :deck_cards

  validates :name, presence: true, uniqueness: true

  after_create :assign_cards

  private

  def assign_cards
    Card.all.each do |card|
      self.deck_cards.create!(card: card)
    end
  end
end
