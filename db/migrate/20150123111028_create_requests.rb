class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :category
      t.text :description
      t.string :link
	  t.integer :votes

      t.timestamps
    end
  end
end
