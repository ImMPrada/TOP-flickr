class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :flickr_username, :string
    add_column :users, :flickr_uid, :string
    add_index :users, :flickr_uid, unique: true
  end
end
