module Tickets
  class Index
    def initialize(params)
      @registration = params[:registration] if params[:registration]
      @color = params[:color] if params[:color]
      @slot_name = params[:slot_name] if params[:slot_name]
    end

    def call
      car_conditions = {}
      slot_conditions = {}

      car_conditions[:cars] = { registration: @registration } if @registration.present?
      car_conditions[:cars] = { color: @color } if @color.present?
      slot_conditions[:slots] = { name: @slot_name } if @slot_name.present?

      tickets = Ticket.includes(:car, :slot).where(is_deleted: false)
      tickets = tickets.joins(:car).where(car_conditions)
      tickets = tickets.joins(:slot).where(slot_conditions)

      if tickets.any?
        result = { success: true, tickets: tickets }
      else
        result = { success: false, error_message: I18n.t('ticket.error.found') }
      end
    end
  end
  
end