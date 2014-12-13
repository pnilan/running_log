class RemoveTypeIdFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :type_id, :integer
  end
end
