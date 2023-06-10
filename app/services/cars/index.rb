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

      cars = Car.where(conditions)

      if cars.any?
        result = { success: true, cars: cars }
      else
        result = { success: false, message: "No cars found with the provided criteria" }
      end
    end
  end
end