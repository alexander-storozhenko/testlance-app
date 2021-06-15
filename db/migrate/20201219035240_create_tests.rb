class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :test_templates do |t|
      t.string :title
      t.string :sub_title
      t.integer :status, default: 0

      #TODO Rating
      t.float :likes, default: 0

      #TODO Views
      t.integer :plays, default: 0

      t.json :rating_raw, default: [0,0,0,0,0]

      t.json :options
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
