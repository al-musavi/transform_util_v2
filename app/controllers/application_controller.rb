class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def generate(inputs, input_column_names, output_type)
		inputs.each do |each_input|
			output = output_chooser(output_type, each_input)
			input_column_names.each do |each_column_name|
				# if each_column_name == "in_object"
				# 	byebug
				# end	
				# ref_field = RefFieldSource.find_by name: each_column_name		
				all_ref_fields = RefFieldSource.where name: each_column_name		
				all_ref_fields.each do |ref_field|
					output_column_name = ref_field.dest_field.name
					compare = Compare.find_by(input: each_input.send(each_column_name), ref_field_source_id: ref_field.id)
					if compare == nil 
						output.send(output_column_name+"=", each_input.send(each_column_name)) 
					elsif compare.operator == "ELSE"
						output.send(output_column_name+"=", "NEED TO FIX") 
					else
						ref_field_source = compare.ref_field_source
						dest_field = ref_field_source.dest_field
						ref_fields = dest_field.ref_field_sources
						if ref_fields.length > 1
							output.send(output_column_name+'=', get_output_value(compare, ref_fields, each_input, output_column_name, output, output_type))
						else
							output.send(output_column_name+'=', compare.output) 
						end
					end
				end
			end
			output.save
		end
	end

	def output_chooser(output_type, each_input)
		if output_type == "output1"
			output = Output.find_or_create_by(input_id: each_input.id)
		elsif output_type == "output2"
			output = Output2.find_or_create_by(input_id: each_input.id)
		end
		output
	end

	def get_output_value(compare, ref_fields, each_input, output_column_name, output, output_type)
		@final_output == compare.output
		ref_fields.each do |ref_field|
			
			compare = Compare.find_by(input: each_input.send(ref_field.name), ref_field_source_id: ref_field.id)
			
			if compare != nil && compare.term_point == true && compare.operator == "ELSE" 
				output.send(output_column_name+"=", "NEED TO FIX") 
				break
			elsif compare != nil && compare.term_point == true 
				@final_output = compare.output
				break
			end
		end
		@final_output
	end
end
