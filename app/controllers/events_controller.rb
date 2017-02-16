class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
  end
  
  def new
   render 'new'
  end

  def create
    @event = Event.new title:params[:title] 
    @event.save
  end

  def edit
    render 'editevent'
  end

  def update
    @event = Event.find params[:id]
    @event[:title] = params[:title]
     #do this for each key in event

    @event.save 

  end

  def destroy
    Event.destroy params[:id]
  end
end
