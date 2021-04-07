class CreateTestRecommends < ActiveRecord::Migration[5.0]
  def change
    create_table :test_recommends do |t|
      t.references :recommend
      t.references :test_template
    end
  end
end
