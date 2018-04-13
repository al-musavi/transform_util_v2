class CreateDestFields < ActiveRecord::Migration[5.1]
  def change
    create_table :dest_fields do |t|
      t.string :name

      t.timestamps
    end
  end
end
