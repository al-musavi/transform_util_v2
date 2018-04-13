class CreateCompares < ActiveRecord::Migration[5.1]
  def change
    create_table :compares do |t|
      t.string :input
      t.string :output
      t.boolean :term_point
      t.integer :ref_field_source_id

      t.timestamps
    end
  end
end
