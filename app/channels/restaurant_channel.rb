class RestaurantChannel < ApplicationCable::Channel
  def subscribed
    stream_from "restaurant_#{params[:room]}"
  end
end
