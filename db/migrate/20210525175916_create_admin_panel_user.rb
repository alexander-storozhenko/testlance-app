class CreateAdminPanelUser < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_panel_users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.datetime :remember_created_at
      t.timestamps
    end
  end
end
