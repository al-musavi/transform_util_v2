class CreateOutputs < ActiveRecord::Migration[5.1]
  def change
    create_table :outputs do |t|
      t.string :in_fruit_1
      t.string :in_obj_2
      t.string :in_city_3
      t.string :in_time_4
      t.string :in_id_5
      t.string :in_date_6
      t.string :in_amt_7
      t.integer :input_id

      t.timestamps
    end
  end
end
