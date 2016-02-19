class GameDeck < ApplicationRecord
  belongs_to :game
  belongs_to :deck

  validates :game, :deck, presence: true
end
