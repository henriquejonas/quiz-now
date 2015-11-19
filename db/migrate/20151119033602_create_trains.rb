class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.references :user
      t.integer :score
      t.timestamp :started_at
      t.timestamp :ended_at
      t.timestamps
    end
  end
end
