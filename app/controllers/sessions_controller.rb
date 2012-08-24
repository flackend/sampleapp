class SessionsController < ApplicationController
  def new
  end
  def create
    # find user by email
    # params[:this] = params[:session]
    u = User.find_by_email(params[:session][:email].downcase)
    if u && u.authenticate(params[:session][:password])
      # login success!
    else
      # login failed
      flash.now[:error] = ["Invalid login credentials."]
      render 'new'
    end
  end
  def destroy
  end
end
