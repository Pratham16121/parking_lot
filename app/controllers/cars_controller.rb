class CarsController < ApplicationController
  def create
    result = Cars::Create.new(cars_params).call
    if result[:status] == 200
      flash[:success] = "Car saved"
    else
      flash[:error] = "error"
    end
    redirect_to root_path
  end

  def index
    result = Cars::Index.new(search_parmas).call
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
