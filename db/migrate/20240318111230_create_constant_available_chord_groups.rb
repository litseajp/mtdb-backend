class CreateConstantAvailableChordGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_available_chord_groups do |t|
      t.references :available_chord_category, foreign_key: { to_table: :constant_available_chord_categories }
      t.references :degree, foreign_key: { to_table: :constant_degrees }
      t.string :function, null: false

      t.timestamps
    end
  end
end
