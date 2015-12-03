class GamesController < ApplicationController

	def matchmaking
		current_user.update_attribute(:status, :searching) if current_user.status == :online
	end

	def start_match
		@game = Game.current_for_player(current_user).try(:last)

		if @game && (@game.status == :waiting_for_players || @game.status == :started)
			@game.update_attribute :status, :started
			current_user.update_attribute :status, :playing
		elsif @game && @game.status == :cancelled
			current_user.update_attribute :status, :online
			redirect_to root_path, alert: 'O oponente saiu da partida.'
		else
			redirect_to root_path, alert: 'Não foram encontradas partidas a serem jogadas.'
		end
	end

	def answer_question
		@game = Game.current_for_player(current_user).try(:last)

		if @game
			answer_id   = params[:answer_id]
			question_id = params[:question_id]
			time        = params[:time]
			points      = time.to_i * 5;
			answer      = @game.game_questions.by_question(question_id).by_user(current_user).first
			correct     = Question.find(question_id).answers.correct.try(:first)
			is_finished = params[:last].to_i == 9

			unless Answer.find_by(id: answer_id).blank? 
				answer.update_attributes(answer_id: answer_id, time: time, points: points)
				if time == 0 || (!correct.nil? && correct.id != answer_id.to_i)
					answer.update_attributes(points: 0)
					render json: Game.find(@game.id), meta: { status: 0, correct_answer_id: correct.try(:id), finished: is_finished }
				else
					render json: Game.find(@game.id), meta: { status: 2, finished: is_finished }
				end
			else
				render json: Game.find(@game.id), meta: { status: 1, correct_answer_id: correct.try(:id), finished: is_finished }
			end
		end
	end

	def finalize_match
		current_user.update_attribute(:status, :online)

		@game     = Game.for_player(current_user).try(:last)
		@oponnent = @game.player_1 == current_user ? @game.player_2 : @game.player_1

		@game.update_attribute(:status, :terminated)
	end

	def cancel_match
		game_id = params[:game_id]
		game    = Game.find_by(id: game_id) if game_id

		game.cancel(current_user) if game
		redirect_to root_path
	end

	def find_match
		game      = Game.valid_for_player(current_user.id)
		oponnents = User.with_status(:searching).not_user(current_user).order('RAND()').limit(1)

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