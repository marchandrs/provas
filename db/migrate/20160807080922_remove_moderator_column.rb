class RemoveModeratorColumn < ActiveRecord::Migration
  def change
    remove_column :users, :moderator
  end
end
