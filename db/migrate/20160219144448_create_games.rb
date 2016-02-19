class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.integer :bet, null: false
      t.integer :admin_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
