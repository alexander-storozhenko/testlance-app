class CreateMobileDevice < ActiveRecord::Migration[5.2]
  def change
    create_table :mobile_devices do |t|
      t.belongs_to :user
      t.integer :platform
      t.string :token

      t.timestamps
    end
  end
end
