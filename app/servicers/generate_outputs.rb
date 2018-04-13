class GenerateOutputs < Generic::Strict
	attr_accessor :inputs

	def initialize(*)
		super
		generate
	end

	def generate
		input_column_names = Input.column_names

		inputs.each do |each_input|
			output = Output.find_or_create_by(input_id: each_input.id)
			input_column_names.each do |each_column_name|
				compare = Compare.find_by input: each_input.each_column_name
				if compare == nil 
					output.each_column_name == each_input.name
				else
					ref_field_source = compare.ref_field_source
					dest_field = ref_field_source.dest_field
					ref_fields = dest_field.ref_field_source
					output.each_column_name = compare.output
					if ref_fields.length > 1
						[2..ref_fields.length] do |var_index|
							if compare.term_point == true || var_index == ref_fields.length
								break
							else						
								ref_field = ref_fields.find_by var_level: var_index
								compare = Compare.find_by ref_field_soure_id: ref_field.id
								output.each_column_name = compare.output
							end
						end	
					end
				end
			end
			output.save
		end
	end
end


