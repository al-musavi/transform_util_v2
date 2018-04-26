class AddVarSourceValueToRefFieldSource < ActiveRecord::Migration[5.1]
  def change
    add_column :ref_field_sources, :var_source_value, :string
  end
end
