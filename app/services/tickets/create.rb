module Tickets
  class Create
    def initialize(params)
      @registration = params[:registration]
    end

    def call
      return { error_message: I18n.t('ticket.error.registration') } unless Car.find_by(registration: @registration)
      assigned_slot = find_assigned_slot
      unless assigned_slot[:success]
        return { error_message: I18n.t('ticket.error.slot') }
      end

      @car_id = Car.find_by(registration: @registration).id

      newTicket = Ticket.new(car_id: @car_id, assigned_slot: assigned_slot[:slot])
      if newTicket.save
        { success_message: I18n.t('ticket.success.create') }, status: 200 }
      else
        { error_message: newTicket.errors.full_messages.join(", "), status: 400 }
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