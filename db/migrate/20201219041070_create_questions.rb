class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_templates do |t|
      t.integer :question_type
      t.integer :number

      t.string :text

      t.json :answers
      t.json :true_answers
      t.json :data

      t.belongs_to :test_template
    end

    create_table :questions do |t|
      t.integer :number
      t.json :user_answers, default: {}
      t.belongs_to :user
      t.belongs_to :test, null: true
      t.belongs_to :question_template
    end
  end
end
