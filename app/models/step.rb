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
  belongs_to :game_card, optional: true
  belongs_to :game

  enum kind: [:game_start, :hit, :stand, :card_assigned, :game_over]
end
