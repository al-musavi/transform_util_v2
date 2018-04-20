class CreateOutput2s < ActiveRecord::Migration[5.1]
  def change
    create_table :output2s do |t|
      t.string :out_objshape
      t.string :out_objcolor
      t.string :out_foodcolorage
      t.string :out_placesize
      t.string :out_id

      t.timestamps
    end
  end
end
