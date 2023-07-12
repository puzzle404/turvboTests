class RestaurantChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'restaurant_33'
  end
end
