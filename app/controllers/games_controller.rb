class GamesController < ApplicationController

	def matchmaking
	end

	def start_match
		@game = Game.valid_for_player current_user

		if @game
			
		end

	end

	def cancel_match
		game_id = params[:game_id]
		game    = Game.find_by(id: game_id) if game_id

		game.cancel(current_user) if game
		redirect_to root_path
	end

	def find_match
		game      = Game.valid_for_player(current_user.id)
		oponnents = User.with_status(:online).not_user(current_user).order('RAND()').limit(1)

		if game.blank? && !oponnents.blank?
			oponnent = oponnents.first
			new_game = Game.new player_1: current_user, player_2: oponnent

			# add questions in a game
			questions = Question.order('RAND()').limit(10)
			questions.each do |q|
				new_game.game_questions << GameQuestion.new(question: q, user: current_user)
				new_game.game_questions << GameQuestion.new(question: q, user: oponnent)
			end

			# change player status
			current_user.update_attribute :status, :waiting
			new_game.save

			render json: game
		elsif game.blank? && oponnents.blank?
			render json: { status: 0 }
		elsif !game.blank?
			# change player status
			current_user.update_attribute :status, :waiting
			render json: Game.find(game.first.id)
		end

	end

end