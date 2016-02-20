# == Schema Information
#
# Table name: game_cards
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  card_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
