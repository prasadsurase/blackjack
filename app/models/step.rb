# == Schema Information
#
# Table name: steps
#
#  id           :integer          not null, primary key
#  game_id      :integer
#  game_card_id :integer
#  kind         :integer          default("game_start"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Step < ApplicationRecord
  belongs_to :game_card, optional: true #through we game_card, we get access to all the models(game, card, user) for this step
  belongs_to :game #step always belongs to a step

  enum kind: [:game_start, :hit, :stand, :card_assigned, :game_over] #types of steps
end
