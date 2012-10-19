class SessionsController < ApplicationController
  def new
  end
  def create
    # Find user by email
    user = User.find_by_email(params[:email].downcase)
    # If user was found and authenticates with give password
    if user && user.authenticate(params[:password])
      # Login success!
      # Pass user to session helper
			sign_in user
			# Redirect to user and display flash notice
			redirect_to user, notice: ["Welcome #{user.name}!"]
    else
      # Login failure :(
      # Note that error msg is a string inside of an array
      flash.now[:error] = ["Invalid login credentials."]
      render :new
    end
  end
  def destroy
    sign_out
    redirect_to users_url, notice: ["You have been successfully signed out."]
  end
end
