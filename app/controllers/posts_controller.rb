class PostsController < ApplicationController
  def index
    @post = Post.all 
  end

  def show
     @post = Post.new  anchor_text:params[:anchor_text], comment:params[:comment]
    @post.save
    redirect_to '/main'
  end

  def new
     @assigned = session[:user_id] 
  end

  def create
    @event_id = params[:id]
  end


  def edit
  end

  def update
  end
end
