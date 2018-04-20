class CreateInput2s < ActiveRecord::Migration[5.1]
  def change
    create_table :input2s do |t|
      t.string :in_object
      t.string :in_food
      t.string :in_place
      t.integer :in_id
      t.date :in
      t.integer :in_amt

      t.timestamps
    end
  end
end
