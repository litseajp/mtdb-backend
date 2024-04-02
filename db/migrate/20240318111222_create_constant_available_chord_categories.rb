class CreateConstantAvailableChordCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_available_chord_categories do |t|
      t.string :majmin, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
