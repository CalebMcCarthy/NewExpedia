class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def show
    @post = Post.find params[:id]
  end

  def new
     @assigned = session[:user_id]
  end

  def create
    @post = Post.new anchor_text:params[:anchor_text], comment:params[:comment]
    @post.save
  end

  def edit
  end

  def update
  end
end
