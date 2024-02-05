class CreateConstantScaleTonetypes < ActiveRecord::Migration[7.1]
  def change
    create_table :constant_scale_tonetypes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
