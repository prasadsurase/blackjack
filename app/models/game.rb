class Game < ApplicationRecord
  belongs_to :user
  belongs_to :admin, -> { where admin: true }, class_name: 'User', foreign_key: :admin_id

  validates :user, :admin, presence: true
  validates :bet, numericality: { only_integer: true, greater_than: 0 }, presence: true
end
