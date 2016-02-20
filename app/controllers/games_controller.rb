class GamesController < ApplicationController
  def index
    @games = Game.all.includes([:admin, :user])
    @games_won_by_dealer = admin_user.games_won.count
    @games_won_by_user = current_user.games_won.count
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
