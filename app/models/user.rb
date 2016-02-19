class User < ApplicationRecord
  has_many :games
  has_many :admin_games, class_name: 'Game', foreign_key: :admin_id

  validates :name, presence: true
end
