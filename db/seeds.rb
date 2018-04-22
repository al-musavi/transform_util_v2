require 'csv'
require 'date'
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# DEST_FIELD_SEEDS = ["out_color_1", "out_shape_2", "out_state_3", "out_daytime_4", "out_id_5", "out_date_6", "out_amt_7"]

# REF_FIELD_SEEDS = {"in_fruit_1" => ["out_color_1", 1, "="], "in_obj_2" => ["out_shape_2", 1, "="], "in_city_3" => ["out_state_3", 1, "="], "in_time_4" => ["out_daytime_4", 1, "="], "in_id_5" => ["out_id_5", 1, "="], "in_date_6" => ["out_date_6", 1, "="], "in_amt_7" => ["out_amt_7", 1, "="], "in_bruise_8" => ["out_color_1", 2, "="], "in_size_9" => ["out_color_1", 3, "="]}

# COMPARE = [["apple", "red", false, "in_fruit_1"], ["banana", "yellow", true, "in_fruit_1"], ["lime","green", true, "in_fruit_1"], ["carrot", "orange", true, "in_fruit_1"], ["stop_sign", "octagon", true, "in_obj_2"], ["basketball", "sphere", true, "in_obj_2"], ["box", "cube", true, "in_obj_2"], ["tv", "rectangle", true, "in_obj_2"], ["chicago", "illinois", true, "in_city_3"], ["boston", "massachusetts", true, "in_city_3"], ["phoenix", "arizona", true, "in_city_3"], ["seattle", "washington", true, "in_city_3"], ["8a", "morning", true, "in_time_4"], ["12pm", "noon", true, "in_time_4"], ["4pm", "afternoon", true, "in_time_4"], ["10pm", "night", true, "in_time_4"], ["Bruised", "Bad Apple", true, "in_bruise_8"], ["Not Bruised", "Good Apple", false, "in_bruise_8"], ["Large", "Really Good Apple", true, "in_size_9"],["Small", "OK Good Apple", true, "in_size_9"]]

# INPUTS = [

# ["apple",	"stop_sign",	"chicago",	"8a",	"9617",	"43165",	"21",	"Not Bruised",	"Large"],
# ["banana", "basketball", "boston", "12p" , "9618",	"43165",	"7",	"Bruised",	"Small"],
# ["lime",	"box",	"phoenix",	"4p",	"9619",	"43165",	"13",	"Not Bruised",	"Large"],
# ["carrot",	"tv",	"seattle",	"10p",	"9620",	"43165",	"16",	"Bruised",	"Small"],
# ]

# DEST_FIELD_SEEDS.each do |each_dest_field|
# 	dest_field = DestField.find_or_create_by(name: each_dest_field)
# 	dest_field.save
# end

# REF_FIELD_SEEDS.each do |k, v|
# 	p "the k and v #{k} and #{v}"
# 	ref_field = RefFieldSource.find_or_create_by(name: k)
# 	dest_field = DestField.find_by name: v[0]
# 	p "dest_field the v #{dest_field} #{v[0]}"
# 	ref_field.update_attributes(dest_field_id: dest_field.id, var_level: v[1], operator: v[2])
# 	ref_field.save
# end

# INPUTS.each do |each_input|
# 	inputs = Input.find_or_create_by("in_fruit_1" => each_input[0])
# 	inputs.update_attributes("in_obj_2" => each_input[1], "in_city_3" => each_input[2], "in_time_4" => each_input[3], "in_id_5" => each_input[4], "in_date_6" => each_input[5], "in_amt_7" => each_input[6], "in_bruise_8" => each_input[7], "in_size_9" => each_input[8])
# 	inputs.save
# end

# COMPARE.each do |each_compare|
# 	compare = Compare.find_or_create_by(input: each_compare[0])
# 	compare.update_attributes(output: each_compare[1], term_point: each_compare[2], ref_field_source_id: (RefFieldSource.find_by name: each_compare[3]).id)
# 	compare.save
# end
def parse_source(source_file_name)
	source_csv = SmarterCSV.process(source_file_name, :row_sep => :auto, :col_sep => ",")

	p source_csv

	source_csv.each do |each_input|
		input = Input2.find_or_initialize_by(in_object: each_input[:in_object].downcase, in_food: each_input[:in_food].downcase, in_place: each_input[:in_place].downcase, in_id: each_input[:in_id], in_date: each_input[:in_date], in_amt: each_input[:in_amt])
		input.save
	end
end

def parse_logic(logic_file_name)
	logic_csv = SmarterCSV.process(logic_file_name, :row_sep => :auto, :col_sep => ",")

	logic_csv.each do |each_logic|
		dest_field = DestField.find_or_initialize_by(name: each_logic[:dest_field].downcase)
		dest_field.save
		ref_field = RefFieldSource.find_or_initialize_by(name: each_logic[:var_source_field].downcase, var_level: each_logic[:var_level], dest_field_id: dest_field.id)
		ref_field.save
		term_point = each_logic[:term_pt] == "Y" ? true : false
		compare = Compare.find_or_initialize_by(input: each_logic[:compare_input], output: each_logic[:var_output], term_point: term_point, operator: each_logic[:compare_operator], ref_field_source_id: ref_field.id, dest_field_id: dest_field.id)
		compare.save
		
		p "the compare errors #{compare.errors.full_messages}"
	end
end
Input2.delete_all
DestField.delete_all
RefFieldSource.delete_all
Compare.delete_all
parse_source("source_table.csv")
parse_logic("logic_table_v1.csv")
parse_logic("logic_table_v2.csv")



