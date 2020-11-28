class ClimbsController < ApplicationController
  before_action :set_climb, only: [:show, :update, :destroy]



  # GET /climbs/:lat/:long
  def getClimbs
    response = RestClient.get "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=#{params[:lat]}&lon=#{params[:long]}&maxDistance=10&minDiff=5.6&maxDiff=5.10&key=200965041-9849b0bf4efa888bd435da7521d00992"
    
    climbs = JSON.parse response

    render json: climbs

  end
  # POST /setToDO
  def settodo
    @climbSetToDo = Climb.find_by_user_id_and_route_id(params[:user_id],params[:route_id])
    @climbCreateToDo = Climb.new(climb_params)

    if @climbSetToDo
      render json: @climbSetToDo
    else
      @climbCreateToDo.save
      render json: @climbCreateToDo
    end

  end

  # PUT /setTickList/:user_id/:route_id
  def setticklist
    @climbs = Climb.find_by_user_id_and_route_id(params[:user_id],params[:route_id])
    
    @climbCreateTick = Climb.new(climb_params)

    if @climbs
      @climbs.update(ticklist:true)
      render json: @climbs
    else
      @climbCreateTick.save
      render json: @climbCreateTick
    end
  end

  # GET /getticklist/:user_id
  def getticklist
    @climbs = Climb.where(user_id: params[:user_id], ticklist: true)

    render json: @climbs
  end
  
  # GET /gettodolist/:user_id
  def gettodolist
    @climbs = Climb.where(user_id: params[:user_id], ticklist: false)

    render json: @climbs
  end

  #GET /getuserchart/:user_id
  def getuserchart
    @climbs = Climb.where(user_id: 1).where('substr(rating, 1, 1) = ?', '5').group(:rating).count

    render json: @climbs
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

    render json: @climb
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb
      @climb = Climb.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def climb_params
      params.fetch(:climb, {}).permit(:route_id, :name, :style, :rating, :stars, :pitches, :url, :latitude, :longitude, :ticklist, :user_id, location: [])
    end
end
