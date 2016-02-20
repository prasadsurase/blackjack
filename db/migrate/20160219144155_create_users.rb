class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.boolean :admin, default: false
      t.integer :blackjacks, default: 0, null: false
      t.integer :busts, default: 0, null: false
      t.integer :majorities, default: 0, null: false

      t.timestamps
    end
  end
end
