class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.string  :in_fruit_1
    t.string  :in_obj_2
    t.string  :in_city_3
    t.string  :in_time_4
    t.string  :in_id_5
    t.string  :in_date_6
    t.string  :in_amt_7
    t.string  :in_bruise_8
    t.string  :in_size_9
      t.timestamps
    end
  end
end
