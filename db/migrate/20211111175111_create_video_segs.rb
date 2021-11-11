class CreateVideoSegs < ActiveRecord::Migration[5.2]
  def change
    create_table :video_segs do |t|
      t.references :video
      t.integer :number
    end
  end
end
