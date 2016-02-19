class CreateGameDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :game_decks do |t|
      t.references :game, foreign_key: true
      t.references :deck, foreign_key: true

      t.timestamps
    end
  end
end
