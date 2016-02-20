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

#a record for this table is created whenever a card is assigned to a user(dealer or player)
class GameCard < ApplicationRecord
  belongs_to :game
  belongs_to :card
  belongs_to :user

  after_create :create_step

  private

  #create the step whenever card is assigned to any user
  def create_step
    game.steps.create!(kind: :card_assigned, game_card: self)
  end
end
