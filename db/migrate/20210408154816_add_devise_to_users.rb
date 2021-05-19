# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              unique: true, null: false, default: ""
      t.string :name,               null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.integer :role,               null: false, default: 0
      t.integer :login_type,         default: 0
      t.string :image_url,           default: ""
      t.string :google_access_token, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
