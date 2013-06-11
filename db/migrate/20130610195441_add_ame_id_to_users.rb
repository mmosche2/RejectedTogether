class AddAmeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ame_user_id, :integer
  end
end
