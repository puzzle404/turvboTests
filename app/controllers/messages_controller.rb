class MessagesController < ApplicationController
  before_action do
   @convertation = Convertation.find(params[:convertation_id])
  end

  def index
    @messages = @convertation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
      end
      if params[:m]
      @over_ten = false
      @messages = @convertation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
      @messages.last.read = true;
      end
    end
    @message = @convertation.messages.new
  end
  def new
    @message = @convertation.messages.new
  end

  def create
    @message = @convertation.messages.new(message_params)
    if @message.save
      Turbo::StreamsChannel.broadcast_append_to @convertation.id, target: "messages", partial: "messages/message", locals: { message: @message}
      redirect_to convertation_messages_path(@convertation)
    end

  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
