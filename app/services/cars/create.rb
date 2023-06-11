module Cars
  class Create
    def initialize(params)
      @registration = params[:registration]
      @color = params[:color]
    end
    
    def call
      newCar = Car.new(registration: @registration, color: @color)
      if newCar.save
        { success_message: I18n.t('car.success.create'), status: 200 }
      else
        { error_message: newCar.errors.full_messages.join(", "), status: 400 }
      end
    end
  end
end