class ConvertationsController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Convertation.all
  end

  def create
    if Convertation.between(params[:sender_id],params[:recipient_id])
      .present?
        @conversation = Convertation.between(params[:sender_id],
        params[:recipient_id]).first
    else
      @conversation = Convertation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
