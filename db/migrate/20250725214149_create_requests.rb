class CreateRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :requests do |t|
      t.string :ip_adress
      t.string :query

      t.timestamps
    end
  end
end
