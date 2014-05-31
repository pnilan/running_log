class RemoveDurationFromActivities < ActiveRecord::Migration
  def change
  	remove_column :activities, :duration
  end
end
