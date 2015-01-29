class AddCategoryToStreams < ActiveRecord::Migration
  def change
    # before the change:
    # t.string :title
    # t.string :category
    # t.text :description
    # t.string :imdbLink
    # t.string :wikipediaLink
    # t.string :rottenTomatoesLink
    # t.timestamps

    remove_column :streams, :category
    add_column :streams, :category, :integer

    # after the change:
    # t.string :title
    # t.integer :category
    # t.text :description
    # t.string :imdbLink
    # t.string :wikipediaLink
    # t.string :rottenTomatoesLink
    # t.timestamps
  end
end
