class UsersController < ApplicationController
  def new
  end
  def create
  	newUser = User.new(username: params[:username], email: params[:email], password: params[:password])
  	if newUser.valid? 
  		newUser.save
  		session[:user_id] = newUser.id 
  		redirect_to "/"
  	else 
  		# errors 
  	end
  end
end
