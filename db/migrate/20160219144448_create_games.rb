class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.integer :bet, null: false
      t.integer :admin_id, foreign_key: true, null: false
      t.integer :winner_id, foreign_key: true
      t.column :winning_type, :integer, default: 0

      t.timestamps
    end
  end
end
