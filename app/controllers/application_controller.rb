class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def inputs(input_type)
		if input_type == "input1"
			@inputs = Input.all
		elsif input_type == "input2"
			@inputs = Input2.all
		end
		@inputs
	end

	def get_input_column_names(input_type)
		if input_type == "input1"
			@input_column_names = Input.column_names - ["id"] -["created_at"] - ["updated_at"]
		elsif input_type == "input2"
			@input_column_names = Input2.column_names - ["id"] -["created_at"] - ["updated_at"]
		end
		@input_column_names
	end

	def get_output_column_names(output_type)
		if output_type == "output1"
			@output_column_names = Output.column_names - ["id"] -["created_at"] - ["updated_at"] - ["input_id"]
		elsif output_type == "output2"
			@output_column_names = Output2.column_names - ["id"] -["created_at"] - ["updated_at"] - ["input_id"]
		end
		@output_column_names
	end

	def generate(input_type, output_type)
		inputs(input_type).each do |each_input|

			output = output_chooser(output_type, each_input)
			output_column_names = get_output_column_names(output_type)
			output_column_names.each do |output_column_name|
				dest_field = DestField.find_by name: output_column_name
				ref_fields = dest_field.ref_field_sources
					@var_source_level = nil
				ref_fields.order(var_level: :asc).each do |each_ref_field|
					compares = Compare.where(ref_field_source_id: each_ref_field.id, dest_field_id: dest_field.id)
					if !compares.nil?
						compares.each do |each_compare|
							# if output_column_name == "out_foodcolorage"
							# 	byebug
							# end

							column_type = get_column_type(each_ref_field, input_type)
							if each_compare.input != nil && column_type == :date 
								@input_value = each_compare.input.to_date
							elsif each_compare.input != nil && column_type == :integer
								@input_value = each_compare.input.to_f
							else
								@input_value = each_compare.input
							end
							# if each_ref_field.name == "in_food"
							# 		byebug
							# 	end
							if each_compare.operator == ">=" && @var_source_level == each_ref_field.var_source_value 
								if each_input.send(each_ref_field.name) >= @input_value
									output.send(output_column_name+'=', each_compare.output)
									@var_source_level = each_compare.output
									if each_compare.term_point == true
										@term_point = true
										break
									end

								end
							elsif each_compare.operator == "<=" && @var_source_level == each_ref_field.var_source_value 
								if each_input.send(each_ref_field.name) <= (!@var_source_level.nil? ? @var_source_level : @input_value)
									output.send(output_column_name+'=', each_compare.output)
									@var_source_level = each_compare.output
									if each_compare.term_point == true
										@term_point = true
										break
									end
								end
							elsif each_compare.operator == "<" && @var_source_level == each_ref_field.var_source_value 
								if each_input.send(each_ref_field.name) < @input_value
									output.send(output_column_name+'=', each_compare.output)
									@var_source_level = each_compare.output
									if each_compare.term_point == true
										@term_point = true
										break
									end
								end
							elsif each_compare.operator == "=" && @var_source_level == each_ref_field.var_source_value 
								# if output_column_name == "out_foodcolorage"
								# 	byebug
								# end
								if each_input.send(each_ref_field.name) == @input_value
									output.send(output_column_name+'=', each_compare.output)
									@var_source_level = each_compare.output
									if each_compare.term_point == true
										@term_point = true
										break
									end
								end

							elsif each_compare.operator == "CONTAINS" && @var_source_level == each_ref_field.var_source_value 
								# if output_column_name == "out_foodcolorage"
								# 	byebug
								# end
								if each_input.send(each_ref_field.name).include? @input_value
									output.send(output_column_name+'=', each_compare.output)
									@var_source_level = each_compare.output
									if each_compare.term_point == true
										@term_point = true
										break
									end
								end


							elsif each_compare.operator == "ELSE" && @var_source_level == each_ref_field.var_source_value && each_compare.term_point == false
								output.send(output_column_name+'=', each_compare.output)
								@var_source_level = each_compare.output
								if each_compare.term_point == true
										@term_point = true
										break
									end
							elsif each_compare.operator == "Move As Is" && @var_source_level == each_ref_field.var_source_value && each_compare.term_point == false
								output.send(output_column_name+"=", each_input.send(each_ref_field.name))
								if each_compare.term_point == true
									@term_point = true
									break
								end
								output.save
							end
						end
					end
						# if @term_point == true
						# 	break
						# end
				end
			end
			output.save
		end
	end

# def generate(input_type, output_type)
# 		inputs(input_type).each do |each_input|
# 			output = output_chooser(output_type, each_input)
# 			input_column_names(input_type).each do |each_column_name|
# 				# if each_column_name == "in_object"
# 				# 	byebug
# 				# end	
# 				# ref_field = RefFieldSource.find_by name: each_column_name		
# 				all_ref_fields = RefFieldSource.where name: each_column_name		
# 				all_ref_fields.each do |ref_field|
# 					dest_of_ref = ref_field.dest_field_id
# 					output_column_name = ref_field.dest_field.name
# 					compare = Compare.find_by(input: each_input.send(each_column_name), ref_field_source_id: ref_field.id, dest_field_id: ref_field.dest_field_id)
# 					if compare == nil
# 						compare =  check_if_else(ref_field.id, dest_of_ref)
# 						if compare != nil
# 							output.send(output_column_name+'=', compare.output) 
# 						else
# 							output.send(output_column_name+"=", each_input.send(each_column_name)) 
# 						end
# 					else
# 						ref_field_source = compare.ref_field_source
# 						dest_field = ref_field_source.dest_field
# 						ref_fields = dest_field.ref_field_sources
# 						if ref_fields.length > 1
# 							output.send(output_column_name+'=', get_output_value(compare, ref_fields, each_input, output_column_name, output, output_type, dest_of_ref, input_type))
# 						else
# 							output.send(output_column_name+'=', compare.output) 
# 						end
# 					end
# 				end
# 			end
# 			output.save
# 		end
# 	end
def output_chooser(output_type, each_input)
	if output_type == "output1"
		output = Output.find_or_create_by(input_id: each_input.id)
	elsif output_type == "output2"
		output = Output2.find_or_create_by(input_id: each_input.id)
	end
	output
end

def get_column_type(ref_field, input_type)
	if input_type == "input1"
		Input.columns_hash[ref_field.name].type
	else
		Input2.columns_hash[ref_field.name].type
	end

end 

def get_output_value_for_date(compare, ref_fields, each_input, output_column_name, output, output_type, dest_of_ref, input_type)
	if output_column_name == "out_foodcolorage"
		byebug
	end
end

def get_output_value(compare, ref_fields, each_input, output_column_name, output, output_type, dest_of_ref, input_type)

	@final_output = compare.output
	if compare.term_point == false
		ref_fields.each do |ref_field|
			
			column_type = get_column_type(ref_field, input_type)
			if column_type = :date
				get_output_value_for_date(compare, ref_fields, each_input, output_column_name, output, output_type, dest_of_ref, input_type)
			end
			column_type = get_column_type(ref_field, input_type)

			compare = Compare.find_by(input: each_input.send(ref_field.name), ref_field_source_id: ref_field.id, dest_field_id: ref_field.dest_field_id)
			if compare != nil && compare.term_point == true 
				@final_output = compare.output
				break
			end
		end
	end
	@final_output
end

def check_if_else(ref_field_id, dest_of_ref)
	compare = Compare.find_by(input: nil, ref_field_source_id: ref_field_id, dest_field_id: dest_of_ref)
end
end
