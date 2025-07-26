class AddTimestampToRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :requests, :timestamp, :date
  end
end
