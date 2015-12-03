class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ranking
    @ranking = User.all.reduce([]) do |ranking, user|
      ranking << { player: user, points: Game.for_player(user).reduce(0) { |tt, game| tt += game.player_points user } }
    end
    @ranking.sort! { |a,b| a[:points] <=> b[:points] }
  end

  private

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user != nil
  end
  helper_method :logged_in?
end
