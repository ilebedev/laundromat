class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :token, null: false
      t.belongs_to :user, index: true
      t.string :memo

      t.timestamps
    end
  end
end
