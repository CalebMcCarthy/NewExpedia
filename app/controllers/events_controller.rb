class EventsController < ApplicationController

    API_VERSION = 'v3'
    API_KEY = '2qe8vhv5etpfagbcqsnq68sl4d'
    SHARED_SECRET = 'c5th559a2n1uc'
    TIMESTAMP = Time.now.to_i.to_s

    PRODUCTION_ENDPOINT = 'book.api.ean.com/ean-services/rs/hotel'
    PRODUCTION_PORT = 80

  before_action :loggedinuser, only:[:new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
    @hotels = self.getHotels @event.latitude, @event.longitude

  end

  def new
  # render 'new'
    @assigned = session[:user_id]
  end

  def create
    @event = Event.new name:params[:name], info:params[:info], location:params[:location], time:params[:time], image:params[:image]
    @event.save
    redirect_to '/main'

  end

  def edit
  end

  def update
    @event = Event.find params[:id]
    @event[:name] = params[:name]
    redirect_to '/main'
    redirect_to
     #do this for each key in event

    @event.save

  end

  def destroy
    Event.destroy params[:id]
  end

  def getHotels latitude, longitude

      xml_code = URI::encode(
        "<HotelListRequest>
            <latitude>#{latitude}</latitude>
            <longitude>#{longitude}</longitude>
            <arrivalDate>6/01/2017</arrivalDate>
            <departureDate>6/10/2017</departureDate>
            <RoomGroup>
                <Room>
                    <numberOfAdults>2</numberOfAdults>
                    </Room>
            </RoomGroup>
            <numberOfResults>25</numberOfResults>
        </HotelListRequest>"
      )

      sig = Digest::MD5.hexdigest( API_KEY + SHARED_SECRET + TIMESTAMP )

      request_url = "#{PRODUCTION_ENDPOINT}/#{API_VERSION}/list?cid=501050&minorRev=99&apiKey=#{API_KEY}&locale=en_US&currencyCode=USD&sig=#{sig}&xml=#{xml_code}"
      uri = URI.parse("https://#{request_url}")

      req = Net::HTTP::Get.new(uri.to_s)

      puts request_url

      res = Net::HTTP.start( uri.host, uri.port, use_ssl: true ){

          |http|

          http.request(req)

      }

      responseHash = JSON.parse(res.body)

    #   if responseHash.empty?
    #       raise(StandardError.new("No response from EAN API"))
    #       return
    #   end

      hotels = responseHash['HotelListResponse']['HotelList']['HotelSummary']

      puts hotels
      puts hotels.class

    #   hotels[0].each_key
      hotels[0].each_key { |key| puts key }

      return hotels

  end
end
