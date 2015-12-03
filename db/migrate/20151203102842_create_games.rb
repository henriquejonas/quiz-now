class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.float :score_one
      t.float :score_two

      t.timestamps
    end
  end
end
