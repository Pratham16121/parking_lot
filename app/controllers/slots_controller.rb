class SlotsController < ApplicationController

  def index
    result = Slots::Index.new().call
    render json: result
  end

end
