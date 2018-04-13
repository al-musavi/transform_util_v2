class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def generate(inputs)
		input_column_names = Input.column_names - ["id"]

		inputs.each do |each_input|
			output = Output.find_or_create_by(input_id: each_input.id)
			input_column_names.each do |each_column_name|
				p "each column name #{each_column_name}"
				compare = Compare.find_by input: each_input.send(each_column_name)
				if compare == nil 
					output.send(each_column_name+"=", each_input.send(each_column_name)) 
				else
					ref_field_source = compare.ref_field_source
					dest_field = ref_field_source.dest_field
					ref_fields = dest_field.ref_field_sources
					p "the ref_fields #{ref_fields}"
					output_column_name = (ref_fields.find_by var_level: 1).name
					p "the output column name #{output_column_name}"
					output.send(output_column_name+'=', compare.output) 
					if ref_fields.length > 1 && compare.term_point == true 
						(2..ref_fields.length).each do |var_index|
							ref_field = ref_fields.find_by var_level: var_index
							compare = Compare.find_by ref_field_source_id: ref_field.id
							output.send(output_column_name+'=', compare.output) 
						end	
					end
				end
			end
			p "the output #{output.inspect}"
			output.save
		end
	end
end
