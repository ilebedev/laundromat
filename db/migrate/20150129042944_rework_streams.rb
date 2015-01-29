class ReworkStreams < ActiveRecord::Migration
  def change
    # before the change:
    # t.string :title
    # t.integer :category
    # t.text :description
    # t.string :imdbLink
    # t.string :wikipediaLink
    # t.string :rottenTomatoesLink
    # t.timestamps

    remove_column :streams, :category
    remove_column :streams, :wikipediaLink
    remove_column :streams, :rottenTomatoesLink
    remove_column :streams, :imdbLink

    add_column :streams, :imdb_link, :string
    add_column :streams, :date_produced, :datetime
    add_column :streams, :urls, :string
    add_column :streams, :media_type, :string
    add_column :streams, :media_id, :integer
    add_index :streams, [ :media_id ]

    # after the change:
    # t.string :title
    # t.string :description
    # t.string :imdb_ink
    # t.datetime :date_produced
    # t.datetime :created_on
    # t.string :urls
    # t.belongs_to :media, index: true
    # t.timestamps

    create_table :media do |t|
      # has many streams

      t.string :image_url
      t.string :title
      t.integer :type

      t.timestamps
    end
  end
end
