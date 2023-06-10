class TicketsController < ApplicationController
  def create
    result = Tickets::Create.new(ticket_params).call
    if result[:status] == 200
      flash[:success] = "Ticket saved. Slot Alloted"
    else
      flash[:error] = "error"
    end
    redirect_to root_path
  end

  def update
    result = Tickets::Update.new(ticket_params, params[:id]).call
    render json: result, status: result[:status]
  end

  private

  def ticket_params
    params.require(:ticket_data).permit(:id, :car_id, :is_deleted)
  end
end
