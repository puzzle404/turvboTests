class Message < ApplicationRecord
  belongs_to :convertation
  belongs_to :user
  validates_presence_of :body, :convertation_id, :user_id
  def message_time
    created_at.strftime('%m/%d/%Y at %l:%M %p')
  end
end
