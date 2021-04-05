class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :test_templates do |t|
      t.string :title
      t.string :sub_title

      t.integer :likes, default: 0
      t.integer :plays, default: 0

      t.json :colors

      t.belongs_to :user

      t.timestamps
    end

    create_table :tests do |t|
      t.belongs_to :user
      t.belongs_to :test_template

      t.timestamps
    end
  end
end
