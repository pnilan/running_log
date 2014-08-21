class RemoveCaloriesFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :calories, :integer
  end
end
