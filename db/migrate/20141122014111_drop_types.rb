class DropTypes < ActiveRecord::Migration
  def change
  	drop_table :types
  end
end
