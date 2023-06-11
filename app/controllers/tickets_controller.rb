class TicketsController < ApplicationController
  def create
    result = Tickets::Create.new(ticket_params).call
    if result[:status] == 200
      flash[:success] = "Ticket saved. Slot Alloted"
    else
      flash[:error] = result[:error_message]
    end
    redirect_to root_path
  end

  def update
    result = Tickets::Update.new(ticket_params, params[:id]).call
    if result[:status] == 200
      flash[:success] = "Ticket updated."
    else
      flash[:error] = result[:error_message]
    end
    redirect_to root_path
  end

  private

  def ticket_params
    params.require(:ticket_data).permit(:id, :registration, :is_deleted)
  end
end
