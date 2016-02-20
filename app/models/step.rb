class Step < ApplicationRecord
  belongs_to :game_card, optional: true
  belongs_to :game

  enum kind: [:game_start, :hit, :stand, :card_assigned, :game_over]
end
