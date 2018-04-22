class HomeController < ApplicationController
  def index
  	@inputs = Input.all
  	input_column_names = Input.column_names - ["id"] -["created_at"] - ["updated_at"]
  	output = "output1"
  	generate_outputs = generate(@inputs, input_column_names, output)
  	@output_column_names = Output.column_names - ["id"] - ["input_id"] - ["created_at"] - ["updated_at"]
  	@outputs = Output.all.order('created_at ASC')
  	
  	@inputs2 = Input2.all
  	input_column_names = Input2.column_names - ["id"] -["created_at"] - ["updated_at"]
  	output = "output2"
  	@output2_column_names = Output2.column_names - ["id"] - ["input_id"] - ["created_at"] - ["updated_at"]
  	@outputs2 = Output2.all.order('created_at ASC')
  	generate_outputs = generate(@inputs2, input_column_names, output)


  end
end
