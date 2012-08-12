class SiteController < ApplicationController
  def index
  	@controller = params[:controller]
  	@name = :World
  	@users = User.all
  end
end
