class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      # has many streams

      t.string :image_url
      t.string :title
      t.integer :category

      t.timestamps
    end
  end
end
