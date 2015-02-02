class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :image
      t.string   :email
      t.integer  :role
      t.datetime :last_seen
      t.timestamps
    end
  end
end
