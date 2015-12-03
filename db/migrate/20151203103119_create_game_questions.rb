class CreateGameQuestions < ActiveRecord::Migration
  def change
    create_table :game_questions do |t|
      t.references :game, index: true
      t.references :question, index: true
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
