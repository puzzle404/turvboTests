class Restaurant < ApplicationRecord
  validates :name, presence: {message: "No puede estar vacío este campo"}
  # after_create_commit do
  #   # broadcast_update_to :restaurants, target: "notificaciones", partial: "restaurants/notificaciones", locals: { count: Restaurant.where(user: current_user).count}
  #   # broadcast_update_to :restaurants, target: "nuevo_mensaje", partial: "restaurants/mensaje", locals: { mensaje: "manuel Ferrer" }
  #   # broadcast_prepend_to :restaurants
  # end
  belongs_to :user
end
