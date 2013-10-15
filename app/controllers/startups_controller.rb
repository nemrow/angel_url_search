class StartupsController < ApplicationController
  def create
    url = Startup.formatted_url(params[:startup][:company_url])
    startup = Startup.find_by_company_url(url)
    return redirect_to startup_path(startup) if startup
    angel_data = Startup.make_angel_request(url)
    return redirect_to root_path(:error => "That url is not on AngelList") if angel_data['success'] == false
    startup = Startup.create_by_angel_data(angel_data)
    redirect_to startup_path(startup)
  end

  def show
    @startup = Startup.find(params[:id])
  end
end
