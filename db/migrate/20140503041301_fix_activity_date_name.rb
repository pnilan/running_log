class FixActivityDateName < ActiveRecord::Migration
  def change
  	rename_column :activities, :activity_date, :date 
  end
end
