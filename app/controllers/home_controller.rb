class HomeController < ApplicationController
  def index
  	@inputs = Input.all
  	generate_outputs = generate(@inputs)
  	@outputs = Output.all
  end
end
