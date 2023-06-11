require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'validates' do
    let!(:car1) { Car.create!(registration: 'MP09BE0513', color: 'red')}
    let!(:car2) { Car.create!(registration: 'MP09BE0504', color: 'black')}
    context 'registration number' do
      it 'is unique' do
        expect(car2.valid?).to eq(true)
      end
      it 'is not unique' do
        car2.registration = car1.registration
        expect(car2.valid?).to eq(false)
      end
    end
  end
end