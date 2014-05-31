class RemoveTypeFromActivities < ActiveRecord::Migration
  def change
  	remove_column :activities, :type
  end
end
