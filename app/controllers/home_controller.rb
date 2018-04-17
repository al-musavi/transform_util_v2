class HomeController < ApplicationController
  def index
  	@inputs = Input.all
  	generate_outputs = generate(@inputs)
  	@output_column_names = Output.column_names - ["id"] - ["created_at"] - ["updated_at"]
  	@outputs = Output.all
  end
end
