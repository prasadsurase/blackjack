class CreateDeckCards < ActiveRecord::Migration[5.0]
  def change
    create_table :deck_cards do |t|
      t.references :deck, foreign_key: true, null: false
      t.references :card, foreign_key: true, null: false

      t.timestamps
    end
  end
end
