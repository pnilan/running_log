class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type
      t.date :activity_date
      t.float :distance
      t.time :duration
      t.time :pace
      t.text :content
      t.integer :calories
      t.integer :bpm

      t.timestamps
    end
  end
end
