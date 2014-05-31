class RemovePaceFromActivities < ActiveRecord::Migration
  def change
  	remove_column :activities, :pace
  end
end
