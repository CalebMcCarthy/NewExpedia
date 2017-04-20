class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def show
    @post = Post.new  anchor_text:params[:title], comment:params[:comment], event_id:params[:id]
    @post.save
    puts "***********"
    puts @post.errors.messages
    redirect_to "/event/#{params[:id]}"
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
