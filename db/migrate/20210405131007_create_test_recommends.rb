class CreateTestRecommends < ActiveRecord::Migration[5.0]
  def change
    create_table :test_recommends do |t|
      t.references :recommend, foreign_key: true
      t.references :test_template, foreign_key: true
    end
  end
end
