class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.integer :creator, null: false
      t.string :description
      t.string :grouptype, null: false

      t.timestamps
    end
  end
end
