class EventsController < ApplicationController
  def index 
    @events = Event.all
  end
  
  def show
    @event = Event.find params[:id]
  end
  
  def new
  # render 'new'
    @assigned = session[:user_id]
  end

  def create
    @event = Event.new name:params[:name], info:params[:info], location:params[:location], time:params[:time]
    @event.save
    redirect_to '/main'

  end

  def edit
  end

  def update
    @event = Event.find params[:id]
    @event[:name] = params[:name]
     #do this for each key in event

    @event.save 

  end

  def destroy
    Event.destroy params[:id]
  end
end
