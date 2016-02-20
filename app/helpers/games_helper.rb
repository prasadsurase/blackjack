# == Schema Information
#
# Table name: games
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  bet          :integer          not null
#  admin_id     :integer          not null
#  winner_id    :integer
#  winning_type :integer          default("majority")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

module GamesHelper
end
