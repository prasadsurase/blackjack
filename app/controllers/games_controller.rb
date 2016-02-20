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

class GamesController < ApplicationController
  def index
    @games = Game.finished.includes([:admin, :user])
  end

  def new
    @game = Game.new(admin: admin_user, user: current_user)
  end

  def create
    @game = Game.new game_params
    @game.admin = admin_user
    @game.user = current_user
    if @game.save
      redirect_to game_path(@game) and return
    end
    render :new
  end

  #show the cards that are assigned to the users
  def show
    @game = Game.find(params[:id])
    @user_cards = current_user.game_cards.where(game: @game).map(&:card)
    @admin_cards = User.first.game_cards.where(game: @game).map(&:card)
  end

  def hit
    @game = Game.find(params[:id])
    @game.hit
    redirect_to game_path(@game) and return
  end

  def stand
    @game = Game.find(params[:id])
    @game.stand
    redirect_to game_path(@game) and return
  end

  private

  def game_params
    params.require(:game).permit(:bet)
  end
end
