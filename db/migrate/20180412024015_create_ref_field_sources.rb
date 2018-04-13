class CreateRefFieldSources < ActiveRecord::Migration[5.1]
  def change
    create_table :ref_field_sources do |t|
      t.string :name
      t.integer :var_level
      t.integer :dest_field_id
      t.string :operator
      t.timestamps
    end
  end
end
