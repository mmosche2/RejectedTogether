class AddPwTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pw_token, :string
  end
end
