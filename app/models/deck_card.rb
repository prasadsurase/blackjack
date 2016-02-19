class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  validates :deck, :card, presence: true
  validates :deck_id, uniqueness: {scope: :card_id}
end
