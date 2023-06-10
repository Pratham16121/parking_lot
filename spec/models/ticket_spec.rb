require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let!(:car) { Car.create!(registration: 'MP09BE23', color: 'white')}
  let!(:slot) { Slot.create!(name: 'A1', distance: 1, is_empty: true )}

  describe 'validates' do
    context 'new ticket' do
      before do
        @ticket = Ticket.new(car_id: car.id, assigned_slot: slot.id )
      end
      it 'accomodates empty slot' do
        @ticket.save
        expect(@ticket.slot.is_empty).to eq(false)
      end
    end
    
    context 'assigned ticket' do
      before do
        @ticket = Ticket.new(car_id: car.id, assigned_slot: slot.id )
      end
      it 'when deleted, slot becomes empty' do
        @ticket.is_deleted = true
        @ticket.save
        expect(@ticket.slot.is_empty).to eq(true)
      end
    end
  end
end
