class FixColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :input2s, :in, :in_date
  end
end
