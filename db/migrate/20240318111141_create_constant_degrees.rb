class CreateConstantDegrees < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_degrees do |t|
      t.string :name, null: false
      t.references :interval, foreign_key: { to_table: :constant_intervals }

      t.timestamps
    end
  end
end
