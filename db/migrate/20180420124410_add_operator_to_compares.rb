class AddOperatorToCompares < ActiveRecord::Migration[5.1]
  def change
    add_column :compares, :operator, :string
  end
end
