class AddDefaultToReleaseOption < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :release_option, :integer, default: 0, null: false
  end
end
