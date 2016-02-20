# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CARD_TYPES.each do |type|
  CARD_VALUES.each do |num|
    Card.create!(name: "#{num}-#{type}")
  end
end

6.times do |i|
  Deck.create!(name: "Deck #{i+1}")
end

User.create!([{name: 'Dealer', admin: true}, {name: 'Player'}])

#User.create!(email: 'admin@blackjack.com', password: 'password123', password_confirmation: 'password123', admin: true)
#User.create!(email: 'prasad@blackjack.com', password: 'password123', password_confirmation: 'password123')
