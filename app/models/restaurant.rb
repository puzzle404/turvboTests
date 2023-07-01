class Restaurant < ApplicationRecord
  validates :name, presence: {message: "No puede estar vacío este campo"}
  after_create_commit -> { broadcast_prepend_to "restaurants"}
end
