class UsersController < ApplicationController
  def new
  end

  def editprofile
  end

  def show
  @user = User.find(params[:id])

  end

  def update
    @user = User.find params[:id]
    @user[:username] = params[:username]
    redirect_to "/main"
     #do this for each key in event
    @user.save
  end

  def create
  	newUser = User.new(username: params[:username], email: params[:email], password: params[:password], image: params[:image])
  	if newUser.valid?
  		newUser.save
  		session[:user_id] = newUser.id
  		redirect_to "/main"
  	else
      flash[:errors] = newUser.errors.full_messages
      redirect_to :back

  	end
  end
end
