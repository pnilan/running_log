class RemoveBpmFromActivities < ActiveRecord::Migration
  def change
  	remove_column :activities, :bpm
  end
end

