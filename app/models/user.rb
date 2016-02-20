class User < ApplicationRecord
  has_many :games
  has_many :admin_games, class_name: 'Game', foreign_key: :admin_id
  has_many :games_won, class_name: 'Game', foreign_key: :winner_id
  has_many :game_cards

  validates :name, presence: true

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
