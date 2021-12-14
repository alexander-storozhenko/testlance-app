class AddTagRefToTestTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :test_templates, :tags, :integer, array: true, default: []
  end
end
