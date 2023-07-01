class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
    @count =@restaurants.count
  end

  # GET /restaurants/1
  def show
  end

  # GET /restaurants/new


  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    respond_to do |format|
      if @restaurant.save
        @count = Restaurant.all.count

        @mensaje = "Restaurant was successfully created."
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully created."}
        format.turbo_stream
        flash.now[:notice] = @mensaje
      else
        format.html { render :new, status: :unprocessable_entity}
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: { restaurant: @restaurant } }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        @mensaje = "Restaurant was successfully created."
          format.html { redirect_to @restaurant, notice: "Restaurant was successfully created."}
          format.turbo_stream { render :update, locals: { restaurant: @restaurant } }
          flash.now[:notice] = @mensaje

      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: "Restaurant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :rating)
    end
end
