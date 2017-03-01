class LoginController < ApplicationController
	def login
	end

	def received
		@user= User.where(username:params[:username]).first
		if @user && @user.authenticate(params[:password])
			session[:user_id]=@user.id
			redirect_to '/main'

		else 
			flash[:errors] = 'LOGIN FAILED'
      		redirect_to :back

 
      	end 
	end

def logout
	reset_session
	redirect_to '/'
end
	def index
	end
end

