class CreateChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :choices do |t|
      t.references :question, null: false, foreign_key: true
      t.string :result_answer, null: false
      t.string :choice_2, null: false
      t.string :choice_3, null: false
      t.string :choice_4, null: false
      t.integer :answer_time, null: false
      t.timestamps
    end
  end
end
