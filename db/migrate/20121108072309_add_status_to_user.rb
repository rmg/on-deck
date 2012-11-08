class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :present_until, :datetime
    add_column :users, :away_until, :datetime
  end
end
