class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :test
      t.float :value
      t.json :data
    end
  end
end
