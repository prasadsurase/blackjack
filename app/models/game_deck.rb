# == Schema Information
#
# Table name: game_decks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  deck_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameDeck < ApplicationRecord
  belongs_to :game
  belongs_to :deck

  validates :game, :deck, presence: true
end
