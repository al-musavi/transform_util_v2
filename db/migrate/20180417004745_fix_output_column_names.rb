quitclass FixOutputColumnNames < ActiveRecord::Migration[5.1]
  def change
  	rename_column :outputs, :in_fruit_1, :out_color_1
  	rename_column :outputs, :in_obj_2, :out_shape_2
  	rename_column :outputs, :in_city_3, :out_state_3
  	rename_column :outputs, :in_time_4, :out_daytime_4
  	rename_column :outputs, :in_id_5, :out_id_5
  	rename_column :outputs, :in_date_6, :out_date_6
  	rename_column :outputs, :in_amt_7, :out_amt_7
  end
end
