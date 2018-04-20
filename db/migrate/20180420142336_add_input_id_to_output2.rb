class AddInputIdToOutput2 < ActiveRecord::Migration[5.1]
  def change
    add_column :output2s, :input_id, :integer
  end
end
