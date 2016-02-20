# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deck < ApplicationRecord
  has_many :deck_cards
  has_many :cards, through: :deck_cards

  validates :name, presence: true, uniqueness: true

  after_create :assign_cards

  private

  #assign the cards to the deck. Card M-M Deck. DeckCard is the 3rd table.
  def assign_cards
    Card.all.each do |card|
      self.deck_cards.create!(card: card)
    end
  end
end
