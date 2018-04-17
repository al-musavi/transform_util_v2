class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def generate(inputs)
		input_column_names = Input.column_names - ["id"] -["created_at"] - ["updated_at"]

		inputs.each do |each_input|
			p "each_input at the beginning #{each_input.inspect}"

			output = Output.find_or_create_by(input_id: each_input.id)
			input_column_names.each do |each_column_name|
				p "each column name #{each_column_name}"
				output_column_name = (RefFieldSource.find_by name: each_column_name).dest_field.name
				p "each input #{each_input.inspect}"
				original_column = 
				compare = Compare.find_by input: each_input.send(each_column_name)
				p "compare by input is #{compare.inspect}"
				if compare == nil 
					p "each input #{each_input.inspect}"
					p " each input send column name #{each_input.send(each_column_name)}"
					output.send(output_column_name+"=", each_input.send(each_column_name)) 
				else
					ref_field_source = compare.ref_field_source
					dest_field = ref_field_source.dest_field
					ref_fields = dest_field.ref_field_sources
					p "the ref_field_source #{ref_field_source.inspect}"
					p "the dest_fields #{dest_field.inspect}"
					p "the ref_fields #{ref_fields.inspect}"
					p "the input is #{each_input.inspect}"
					p "the output column name #{output_column_name}"
					p "the compare.output is #{compare.output}"
					p "the ref_fields_length is #{ref_fields.length}"
					output.send(output_column_name+'=', compare.output) 
					p "the output after all p's #{output.send(output_column_name)}"
					# if each_column_name == "in_bruise_8"
					# 				byebug
					# 			end
					if ref_fields.length > 1
						(2..ref_fields.length).each do |var_index|
							if compare != nil && compare.term_point == false
								ref_field = ref_fields.find_by var_level: var_index
								p "the compare input in the field length #{compare.input}"
								p "the ref_field source in the field length #{ref_field.id}"
								
								compare = Compare.find_by(input: each_input.send(each_column_name), ref_field_source_id: ref_field.id)
								if compare != nil
									output.send(output_column_name+'=', compare.output) 
								end
							end
						end	
					end
				end
			end
			p "the output #{output.inspect}"
			output.save
		end
	end
end
