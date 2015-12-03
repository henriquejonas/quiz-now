class GameQuestion < ActiveRecord::Base
  belongs_to :game
  belongs_to :question
  belongs_to :answer
  belongs_to :user
end

# == Schema Information
#
# Table name: game_questions
#
#  id          :integer          not null, primary key
#  game_id     :integer
#  question_id :integer
#  answer_id   :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_game_questions_on_answer_id    (answer_id)
#  index_game_questions_on_game_id      (game_id)
#  index_game_questions_on_question_id  (question_id)
#  index_game_questions_on_user_id      (user_id)
#
