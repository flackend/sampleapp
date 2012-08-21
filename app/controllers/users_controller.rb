class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  def create
  	@user = User.create(params[:user])
  	if @user.save
  		flash[:success] = ["Sucess! Welcome to SampleApp!"]
			redirect_to @user
  	else
  		flash.now[:error] = @user.errors.full_messages
  		render 'new'
  	end
  end
  def new
  end
  def edit
  end
  def show
		@user = User.find(params[:id])
  end
  def update
  end
  def destroy
  end
end
