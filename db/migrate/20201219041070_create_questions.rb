class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_templates do |t|
      t.string :question_type

      t.string :text

      t.json :answers
      t.json :true_answers

      t.belongs_to :test_templates
    end

    create_table :questions do |t|
      t.json :user_answers
      t.belongs_to :users
      t.belongs_to :tests
      t.belongs_to :question_templates
    end
  end
end
