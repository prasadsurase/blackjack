# == Schema Information
#
# Table name: deck_cards
#
#  id         :integer          not null, primary key
#  deck_id    :integer          not null
#  card_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  validates :deck, :card, presence: true
  validates :deck_id, uniqueness: {scope: :card_id}
end
