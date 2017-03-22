class EventsController < ApplicationController

    API_VERSION = 'v3'
    API_KEY = '2qe8vhv5etpfagbcqsnq68sl4d'
    SHARED_SECRET = 'c5th559a2n1uc'
    TIMESTAMP = Time.now.to_i.to_s

    PRODUCTION_ENDPOINT = 'api.ean.com/ean-services/rs/hotel/'
    PRODUCTION_PORT = 80


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

  def getHotels

      hotelId = '201252'

      otherElementsStr = '&cid=55505&minorRev=[x]&customerUserAgent=[xxx]&customerIpAddress=[xxx]&locale=en_US&currencyCode=USD'


      sig = Digest::MD5.hexdigest( API_KEY + SHARED_SECRET + TIMESTAMP )

      request_url = "/#{API_VERSION}/list}?apiKey=#{API_KEY} & sig=#{sig} & #{otherElementsStr} & hotelIdList=#{hotelId}"
      req = Net::HTTP::Get.new(request_url)

    #   puts "*******************"
    #   print(PRODUCTION_ENDPOINT)

      res = Net::HTTP.start( PRODUCTION_ENDPOINT, PRODUCTION_PORT, use_ssl: true ){

          |http|

          http.request(req)

      }

      print res


  end
end
