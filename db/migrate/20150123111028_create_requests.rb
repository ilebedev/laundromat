class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :request

      t.timestamps
    end
  end
end
