class CreateAccessToken < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.string :refresh_token
      t.string :salt
      t.datetime :rt_expires_at
      t.datetime :jwt_expires_at
      t.references :user

      t.timestamps
    end
  end
end
