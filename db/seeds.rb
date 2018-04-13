# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DEST_FIELD_SEEDS = ["out_color_1", "out_shape_2", "out_state_3", "out_daytime_4", "out_id_5", "out_date_6", "out_amt_7"]

REF_FIELD_SEEDS = {"in_fruit_1" => ["out_color_1", 1, "="], "in_obj_2" => ["out_shape_2", 1, "="], "in_city_3" => ["out_state_3", 1, "="], "in_time_4" => ["out_daytime_4", 1, "="], "in_id_5" => ["out_id_5", 1, "="], "in_date_6" => ["out_date_6", 1, "="], "in_amt_7" => ["out_amt_7", 1, "="], "in_bruise_8" => ["out_color_1", 2, "="], "in_size_9" => ["out_color_1", 3, "="]}

COMPARE = [["apple", "red", false, "in_fruit_1"], ["banana", "yellow", true, "in_fruit_1"], ["lime","green", true, "in_fruit_1"], ["carrot", "orange", true, "in_fruit_1"], ["stop_sign", "octagon", true, "in_obj_2"], ["basketball", "sphere", true, "in_obj_2"], ["box", "cube", true, "in_obj_2"], ["tv", "rectangle", true, "in_obj_2"], ["chicago", "illinois", true, "in_city_3"], ["boston", "massachusetts", true, "in_city_3"], ["phoenix", "arizona", true, "in_city_3"], ["seattle", "washington", true, "in_city_3"], ["8a", "morning", true, "in_time_4"], ["12pm", "noon", true, "in_time_4"], ["4pm", "afternoon", true, "in_time_4"], ["10pm", "night", true, "in_time_4"], ["Bruised", "Bad Apple", true, "in_bruise_8"], ["Not Bruised", "Good Apple", true, "in_bruise_8"], ["Large", "Really Good Apple", true, "in_size_9"],["Small", "OK Good Apple", true, "in_size_9"]]

INPUTS = [

["apple",	"stop_sign",	"chicago",	"8a",	"9617",	"43165",	"21",	"Not Bruised",	"Large"],
["banana", "basketball", "boston", "12p" , "9618",	"43165",	"7",	"Bruised",	"Small"],
["lime",	"box",	"phoenix",	"4p",	"9619",	"43165",	"13",	"Not Bruised",	"Large"],
["carrot",	"tv",	"seattle",	"10p",	"9620",	"43165",	"16",	"Bruised",	"Small"],
]

DEST_FIELD_SEEDS.each do |each_dest_field|
	dest_field = DestField.find_or_create_by(name: each_dest_field)
	dest_field.save
end

REF_FIELD_SEEDS.each do |k, v|
	p "the k and v #{k} and #{v}"
	ref_field = RefFieldSource.find_or_create_by(name: k)
	dest_field = DestField.find_by name: v[0]
	p "dest_field the v #{dest_field} #{v[0]}"
	ref_field.update_attributes(dest_field_id: dest_field.id, var_level: v[1], operator: v[2])
	ref_field.save
end

INPUTS.each do |each_input|
	inputs = Input.find_or_create_by("in_fruit_1" => each_input[0])
	inputs.update_attributes("in_obj_2" => each_input[1], "in_city_3" => each_input[2], "in_time_4" => each_input[3], "in_id_5" => each_input[4], "in_date_6" => each_input[5], "in_amt_7" => each_input[6], "in_bruise_8" => each_input[7], "in_size_9" => each_input[8])
	inputs.save
end

COMPARE.each do |each_compare|
	compare = Compare.find_or_create_by(input: each_compare[0])
	compare.update_attributes(output: each_compare[1], term_point: each_compare[2], ref_field_source_id: (RefFieldSource.find_by name: each_compare[3]).id)
	compare.save
end