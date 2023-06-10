module Tickets
  class Create
    def initialize(params)
      @car_id = params[:car_id]
      @assigned_slot = params[:assigned_slot]
    end

    def call
      newTicket = Ticket.new(car_id: @car_id, assigned_slot: @assigned_slot)
      if newTicket.save
        { success_message: "Ticket saved successfully", status: 200 }
      else
        { error_message: newTicket.errors.full_messages, status: 400 }
      end
    end
  end  
end