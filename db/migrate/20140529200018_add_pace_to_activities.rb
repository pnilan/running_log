class AddPaceToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :pace, :integer
  end
end
