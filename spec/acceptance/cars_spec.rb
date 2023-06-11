require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Cars" do
  get "/cars" do
    Car.create(registration: 'MP09BE0503', color: 'red')

    example "Listing cars" do
      do_request
      expect(status).to eq 200
    end

    example "Listing cars with parameters" do
      do_request({ registration: 'MP09BE0503' })
      expect(status).to eq 200
    end
  end

  post "/cars" do
    parameter :registration, "Car registration", required: true, scope: :car_data
    parameter :color, "Car color", scope: :car_data

    let(:registration) { 'AB12CD3456' }
    let(:color) { 'blue' }
    let(:car_data) { { registration: registration, color: color } }

    example "Creating a car" do
      do_request
      expect(Car.where(registration: registration).count).to eq(1)
    end

    example "Creating a car with duplicate registration number" do
      # Create a car with the same registration number
      Car.create(registration: registration, color: 'red')
      do_request
      # Still Expect only one car with the registration number
      expect(Car.where(registration: registration).count).to eq(1)
    end
  end
end
