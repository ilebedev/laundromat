class ChangeCategoryInRequest < ActiveRecord::Migration
  def change
    remove_column :requests, :category
    add_column :requests, :type, :integer
  end
end
