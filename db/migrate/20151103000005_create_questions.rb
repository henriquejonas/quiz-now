class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.text :reference
      t.references :category, index: true

      t.timestamps
    end
  end
end
