class ConvertationsController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.all
    @convertations = Convertation.all
  end

  def create
    if Convertation.between(params[:sender_id],params[:recipient_id])
      .present?
        @convertation = Convertation.between(params[:sender_id],
        params[:recipient_id]).first
    else
      @convertation = Convertation.create!(convertation_params)
    end
    redirect_to convertation_messages_path(@convertation)
  end

  private
  def convertation_params
    params.permit(:sender_id, :recipient_id)
  end
end
