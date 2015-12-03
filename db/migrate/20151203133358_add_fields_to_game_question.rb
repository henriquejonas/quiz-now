class AddFieldsToGameQuestion < ActiveRecord::Migration
  def change
    add_column :game_questions, :time, :integer
    add_column :game_questions, :points, :float, default: 0
  end
end
