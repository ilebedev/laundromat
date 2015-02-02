class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :title, index: true
      t.text :description
      t.string :imdb_link
      t.datetime :date_produced

      t.string :image_url
      t.string :video_urls
      t.string :subtitle_urls

      t.belongs_to :medium, index: true

      t.timestamps
    end
  end
end
