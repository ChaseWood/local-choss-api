class ClimbsController < ApplicationController
  before_action :set_climb, only: [:show, :update, :destroy]



  # GET /climbs/:lat/:long
  def getClimbs
    
    
    response = RestClient.get "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=#{params[:lat]}&lon=#{params[:long]}&maxDistance=10&minDiff=5.6&maxDiff=5.10&key=200965041-9849b0bf4efa888bd435da7521d00992"
    climbs = JSON.parse response

    render json: climbs

  end

  # GET /climbs
  # Using RestClient I was able to use the /climbs route to query the end point of my external api for routes! 
  def index
    response = RestClient.get 'https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=40.03&lon=-105.25&maxDistance=10&minDiff=5.6&maxDiff=5.10&key=200965041-9849b0bf4efa888bd435da7521d00992'
    climbs = JSON.parse response

    render json: climbs
    # @climbs = Climb.all

    # render json: @climbs
  end

  # GET /climbs/1
  def show
    render json: @climb
  end

  # POST /climbs
  def create
    @climb = Climb.new(climb_params)

    if @climb.save
      render json: @climb, status: :created, location: @climb
    else
      render json: @climb.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /climbs/1
  def update
    if @climb.update(climb_params)
      render json: @climb
    else
      render json: @climb.errors, status: :unprocessable_entity
    end
  end

  # DELETE /climbs/1
  def destroy
    @climb.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb
      @climb = Climb.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def climb_params
      params.fetch(:climb, {}).permit(:route_id, :name, :type, :rating, :stars, :location, :latitude, :longitude, :ticklist, :climber_id)
    end
end
