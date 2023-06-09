class CarsController < ApplicationController
  def create
    result = Cars::Create.new(cars_params).call
    render json: result, status: result[:status]
  end

  private

  def cars_params
    params.require(:car_data).permit(:registration, :color)
  end
end
