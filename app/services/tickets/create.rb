module Tickets
  class Create
    def initialize(params)
      @car_id = params[:car_id]
    end

    def call
      assigned_slot = find_assigned_slot
      unless assigned_slot[:success]
        return { error_message: "Slots are full" }
      end

      newTicket = Ticket.new(car_id: @car_id, assigned_slot: assigned_slot[:slot])
      if newTicket.save
        { success_message: "Ticket saved successfully", status: 200 }
      else
        { error_message: newTicket.errors.full_messages, status: 400 }
      end
    end

    private
    
    def find_assigned_slot
      empty_slot = Slot.where(is_empty: true).order(distance: :asc).first
      if empty_slot
        { success: true, slot: empty_slot.id }
      else
        { success: false }
      end
    end
  end  
end