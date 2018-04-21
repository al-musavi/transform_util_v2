class RemoveOperatorFromRefFieldSource < ActiveRecord::Migration[5.1]
  def change
    remove_column :ref_field_sources, :operator, :string
  end
end
