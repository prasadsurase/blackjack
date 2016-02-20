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

require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
