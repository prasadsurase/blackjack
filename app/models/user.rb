# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  admin      :boolean          default(FALSE)
#  blackjacks :integer          default(0), not null
#  busts      :integer          default(0), not null
#  majorities :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :games #player's games
  has_many :admin_games, class_name: 'Game', foreign_key: :admin_id #dealer's games
  has_many :games_won, class_name: 'Game', foreign_key: :winner_id
  has_many :game_cards #cards assigned across all games

  validates :name, presence: true

  #get points for the specified game
  def current_points(game)
    game_cards ? game_cards.where(game: game).map(&:card).map(&:value).sum : 0
  end

  def blackjack?(game)
    current_points(game) == 21
  end

  def bust?(game)
    current_points(game) > 21
  end

  def amount_won
    games_won.pluck(:bet).sum
  end
end
