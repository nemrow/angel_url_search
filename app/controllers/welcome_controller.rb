class WelcomeController < ApplicationController
  def index
    @startup = Startup.new
    @all_startups = Startup.all
    @error = params[:error] if params[:error]
  end
end
