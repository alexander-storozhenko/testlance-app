class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :ext
      t.references :user

      t.timestamps
    end
  end
end
