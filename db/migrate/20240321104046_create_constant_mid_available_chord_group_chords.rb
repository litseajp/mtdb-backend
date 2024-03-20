class CreateConstantMidAvailableChordGroupChords < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_mid_available_chord_group_chords do |t|
      t.references :available_chord_group, foreign_key: { to_table: :constant_available_chord_groups }
      t.references :chord, foreign_key: { to_table: :constant_chords }

      t.timestamps
    end
  end
end
