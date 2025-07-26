class CreateRequestAnalytics < ActiveRecord::Migration[8.0]
  def change
    create_table :request_analytics do |t|
      t.references :request, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
