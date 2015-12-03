class HomeController < ApplicationController
  def index

		current_user.update_attribute(:status, :online) if current_user.status == :searching

    if logged_in?
      @last_trains = []
      current_user.trains.where.not(ended_at: nil).order(created_at: :desc).limit(10).each_with_index do |value, index|
        @last_trains << [(index + 1).to_s, value.score, value.duration]
      end
    end
  end
end
