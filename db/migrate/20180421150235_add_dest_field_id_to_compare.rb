class AddDestFieldIdToCompare < ActiveRecord::Migration[5.1]
  def change
    add_column :compares, :dest_field_id, :integer
  end
end
