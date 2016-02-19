class GameCard < ApplicationRecord
  belongs_to :game
  belongs_to :card
  belongs_to :user

  validates :game, :user, :card, presence: true
end
