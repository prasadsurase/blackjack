class GameCard < ApplicationRecord
  belongs_to :game
  belongs_to :card
  belongs_to :user

  validates :game, :user, :card, presence: true

  after_create :create_step

  private

  def create_step
    game.steps.create!(kind: :card_assigned, game_card: self)
  end
end
