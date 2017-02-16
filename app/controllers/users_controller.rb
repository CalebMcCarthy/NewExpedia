class UsersController < ApplicationController
  def new
  end

  def editprofile
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
  	newUser = User.new(username: params[:username], email: params[:email], password: params[:password])
  	if newUser.valid? 
  		newUser.save
  		session[:user_id] = newUser.id 
  		redirect_to "/"
  	else 
      flash[:errors] = newUser.errors.full_messages
      redirect_to :back
  	end
  end
end
