class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
	  t.string :title
	  t.string :category
	  t.text :description
	  t.string :imdbLink
	  t.string :wikipediaLink
	  t.string :rottenTomatoesLink

      t.timestamps
    end
  end
end
