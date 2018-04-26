class HomeController < ApplicationController
  def index
  	input_column_names = Input.column_names - ["id"] -["created_at"] - ["updated_at"]
  	input = "input1"
  	output = "output1"
    generate_outputs = GenerateOutput.new(input_type: input, output_type: output)
  	@output1_column_names = Output.column_names - ["id"] - ["input_id"] - ["created_at"] - ["updated_at"]
  	@outputs = Output.all.order('created_at ASC')
  	
  	input_column_names = Input2.column_names - ["id"] -["created_at"] - ["updated_at"]
  	input = "input2"
  	output = "output2"
  	@output2_column_names = Output2.column_names - ["id"] - ["input_id"] - ["created_at"] - ["updated_at"]
  	@outputs2 = Output2.all.order('created_at ASC')

  	generate_outputs = GenerateOutput.new(input_type: input, output_type: output)


  end
end
