class AddUserIdToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :user_id, :integer
  end
end
