class CarsController < ApplicationController
  def create
    result = Cars::Create.new(cars_params).call
    if result[:status] == 200
      flash[:success] = result[:success_message]
    else
      flash[:error] = result[:error_message]
    end
    redirect_to root_path
  end

  def index
    result = Cars::Index.new(search_parmas).call
    unless result[:success]
      flash[:error] = result[:error_message]
    end    
    @cars_details = result
  end

  private

  def cars_params
    params.require(:car_data).permit(:registration, :color)
  end

  def search_parmas
    params.permit(:registration, :color)
  end
end
