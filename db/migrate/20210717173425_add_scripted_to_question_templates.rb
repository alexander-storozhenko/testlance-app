class AddScriptedToQuestionTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :question_templates, :scripted, :boolean, default: false
  end
end
