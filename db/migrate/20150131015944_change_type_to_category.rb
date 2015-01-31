class ChangeTypeToCategory < ActiveRecord::Migration
  def change
    remove_column :requests, :type
    add_column :requests, :category, :integer
    
    remove_column :media, :type
    add_column :media, :category, :integer
  end
end
