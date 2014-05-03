class ChangeDistanceForActivities < ActiveRecord::Migration
  def change
  	change_table :activities do |t|
  		t.change :distance, :decimal
 	end
  end
end
