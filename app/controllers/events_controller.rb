class EventsController < ApplicationController

    # include EANUtil

  before_action :loggedinuser, only:[:new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
    begin
        @hotels = self.getHotels @event.latitude, @event.longitude
    rescue
        @error_message = "#{$!}"
    ensure
        # code that we want to run no matter what
    end


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

  def showHotel

  end

  def getOneHotelsInformation id
      # will make a request for the info (look below)
  end

  def getHotels latitude, longitude

      api_version = 'v3'
      api_key = '2qe8vhv5etpfagbcqsnq68sl4d'
      shared_secret = 'c5th559a2n1uc'
      timestamp = Time.now.to_i.to_s

      production_endpoint = 'book.api.ean.com/ean-services/rs/hotel'
      production_port = 80

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

      sig = Digest::MD5.hexdigest( api_key + shared_secret + timestamp )

      request_url = "#{production_endpoint}/#{api_version}/list?cid=501050&minorRev=99&apiKey=#{api_key}&locale=en_US&currencyCode=USD&sig=#{sig}&xml=#{xml_code}"
      uri = URI.parse("https://#{request_url}")

      req = Net::HTTP::Get.new(uri.to_s)

      puts request_url

      res = Net::HTTP.start( uri.host, uri.port, use_ssl: true ){

          |http|

          http.request(req)

      }

      responseHash = JSON.parse(res.body)
      puts responseHash
      hotelResponse = responseHash['HotelListResponse']

      unless hotelResponse['EanWsError'] != nil
          hotels = hotelResponse['HotelList']['HotelSummary']
          return hotels
      else
          raise(StandardError.new(hotelResponse['EanWsError']['verboseMessage']))
      end

  end
end
