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

        Turbo::StreamsChannel.broadcast_update_to :restaurants, target: "notificaciones", partial: "restaurants/notificaciones", locals: { count: Restaurant.all.count}
        Turbo::StreamsChannel.broadcast_update_to :restaurants, target: "nuevo_mensaje", partial: "restaurants/mensaje", locals: { mensaje: "manuel Ferrer" }
        Turbo::StreamsChannel.broadcast_prepend_to :restaurants, target: "restaurants", partial: "restaurants/restaurant", locals: { restaurant: @restaurant }
        # format.html { redirect_to @restaurant, notice: "Restaurant was successfully created."}
        format.turbo_stream
        flash.now[:notice] = "Restaurant was successfully created."
      else
        format.html { render :new, status: :unprocessable_entity}
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: { restaurant: @restaurant } }
      end
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  # PATCH/PUT /restaurants/1
  def update
      if @restaurant.update(restaurant_params)
        notify_all_users
        # @mensaje = "Restaurant was successfully created."
        # flash[:notice] = @mensaje
          # redirect_to root_path, notice: "Restaurant was successfully created."
          # @restaurants = Restaurant.all
          flash.now[:notice] = "Restaurant was successfully created."
          render partial: "restaurants/restaurant", locals: { restaurant: @restaurant }
          # format.turbo_stream

      else
        render :edit, status: :unprocessable_entity
      end
  end

   
  def form_turbo_stream
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.turbo_stream
    end
  end 

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
    redirect_to root_path, notice: "Restaurant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def notify_all_users
      ActionCable.server.broadcast("restaurant_#{@restaurant.id}",
        {action: 'updated'})
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :rating, :user_id)
    end
end
