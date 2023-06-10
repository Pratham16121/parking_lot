class SlotsController < ApplicationController

  def index
    result = Slots::Index.new().call
    slots = result
    @grouped_slots = slots.group_by { |slot| slot['name'][0] }
  end
end
