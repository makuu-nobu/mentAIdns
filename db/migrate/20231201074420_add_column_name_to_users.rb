class AddColumnNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :release_option, :integer, null: false
  end
end
