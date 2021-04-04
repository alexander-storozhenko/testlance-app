class AddUserDataToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :user_data, :json, default: {}
  end
end
