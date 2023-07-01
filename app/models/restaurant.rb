class Restaurant < ApplicationRecord
  validates :name, presence: {message: "No puede estar vacío este campo"}
  after_create_commit do
    broadcast_update_to :restaurants, target: "notificaciones", partial: "restaurants/notificaciones", locals: { count: Restaurant.all.count }
    broadcast_prepend_to :restaurants
  end
end
