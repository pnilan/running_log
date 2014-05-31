class AddTypeIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :type_id, :integer
  end
end
