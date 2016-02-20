# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Card < ApplicationRecord
  has_many :deck_cards
  has_many :decks, through: :deck_cards

  validates :name, presence: true, uniqueness: true

  def value
    val = name.split('-')[0]
    case val
    when *VALUES
      val.to_i
    when 'A'
      11
    when *OTHERS
      10
    end
  end
end
