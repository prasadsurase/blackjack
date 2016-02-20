class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.references :game, foreign_key: true
      t.references :game_card, foreign_key: true
      t.column :kind, :integer, default: 0, null: false

      t.timestamps
    end
  end
end
