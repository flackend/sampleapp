class SiteController < ApplicationController
  def index
  	@controller = params[:controller]
  	@name = :World
  end
end
