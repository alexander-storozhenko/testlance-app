class AddDataToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :data, :json, default: {}
  end
end
