class AddRunTypeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :run_type, :string
  end
end
