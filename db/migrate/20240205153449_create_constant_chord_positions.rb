class CreateConstantChordPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_chord_positions do |t|
      t.references :chord, foreign_key: { to_table: :constant_chords }
      t.string :root, null: false
      t.integer :string1, null: false
      t.integer :string2, null: false
      t.integer :string3, null: false
      t.integer :string4, null: false
      t.integer :string5, null: false
      t.integer :string6, null: false

      t.timestamps
    end
  end
end
