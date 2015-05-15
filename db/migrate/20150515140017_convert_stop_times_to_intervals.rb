class ConvertStopTimesToIntervals < ActiveRecord::Migration
  def change
    remove_column :stop_times, :arrival_time
    remove_column :stop_times, :departure_time

    add_column :stop_times, :arrival_time, :interval, null: false
    add_column :stop_times, :departure_time, :interval, null: false
  end
end
