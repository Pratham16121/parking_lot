class TicketsController < ApplicationController
  def index
    result = Tickets::Index.new(search_parmas).call
    unless result[:success]
      flash[:error] = result[:error_message]
    end
    @tickets_details = result
  end
  
  def create
    result = Tickets::Create.new(ticket_params).call
    if result[:status] == 200
      flash[:success] = result[:success_message]
    else
      flash[:error] = result[:error_message]
    end
    redirect_to root_path
  end

  def update
    result = Tickets::Update.new(ticket_params, params[:id]).call
    if result[:status] == 200
      flash[:success] = result[:success_message]
    else
      flash[:error] = result[:error_message]
    end
    redirect_to root_path
  end

  private

  def ticket_params
    params.require(:ticket_data).permit(:id, :registration, :is_deleted)
  end

  def search_parmas
    params.permit(:slot_name, :registration, :color)
  end
end
