module Cars
  class Index
    def initialize(params)
      @registration = params[:registration] if params[:registration]
      @color = params[:color] if params[:color]
    end

    def call
      conditions = {}

      conditions[:registration] = @registration if @registration.present?
      conditions[:color] = @color if @color.present?

      cars = Car.select(:id, :registration, :color)
                .where(conditions)
      active_tickets = Ticket.where(is_deleted: false).select(:car_id)
      if cars.any?
        cars.each do |car|
          car.is_parked = active_tickets.exists?(car_id: car.id)
        end
        sorted_cars = cars.sort_by { |car| [car.is_parked ? 0 : 1, car.id] }
        result = { success: true, cars: sorted_cars.map { |car| car.attributes.merge(is_parked: car.is_parked) } }
      else
        result = { success: false, error_message: I18n.t('car.error.found') }
      end
    end
  end
end