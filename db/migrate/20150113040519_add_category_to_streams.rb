class AddCategoryToStreams < ActiveRecord::Migration
  def change
    remove_column :streams, :category
	add_column :streams, :category, :integer
  end
end
