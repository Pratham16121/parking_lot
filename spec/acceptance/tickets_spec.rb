require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Tickets' do
  let!(:car1) { Car.create!(registration: 'MP09BE0505', color: 'red') }
  let!(:car2) { Car.create!(registration: 'MP09BE0509', color: 'red') }
  let!(:slot1) { Slot.create!(name: 'A1', distance: 1) }
  let!(:slot2) { Slot.create!(name: 'A2', distance: 2) }
  let!(:ticket) { Ticket.create!(car_id: car1.id, assigned_slot: slot1.id) }
  post '/tickets' do
    parameter :registration, 'Registration Number'
    parameter :ticket_data, 'Ticket data', required: true, scope: :ticket

    let(:registration) { car2.registration }
    let(:ticket_data) { { registration: registration } }
    example 'Creating a ticket' do
      do_request(ticket_data: ticket_data)
      expect(Ticket.all.count).to eq 2
    end

    example 'Creating a ticket with unregistered number' do
      registration = "MP09XF0505"
      ticket_data = { registration: registration }
      do_request(ticket_data: ticket_data)
      expect(Ticket.all.count).to eq 1
    end

    example 'Creating a ticket with already existing ticket for the same registration' do
      registration = car1.registration
      ticket_data = { registration: registration }
      do_request(ticket_data: ticket_data)
      expect(Ticket.all.count).to eq 1
    end
    example 'Creating a ticket when there are no empty slots' do
      Slot.update_all(is_empty: false)
      do_request(ticket_data: ticket_data)
      expect(Ticket.all.count).to eq 1
    end
  end

  put '/tickets/:id' do
    parameter :id, 'Ticket ID', required: true
    parameter :ticket_data, 'Ticket data', required: true, scope: :ticket

    let(:id) { ticket.id }
    let(:ticket_data) { { is_deleted: true } }
    example 'Updating a ticket' do
      do_request(ticket_data: ticket_data)

      expect(Ticket.find(ticket.id).is_deleted).to eq true
    end

    example 'Updating a non-existing ticket' do
      id = 0
      do_request(ticket_data: ticket_data)
      expect(Ticket.where(is_deleted: false).count).to eq 0
    end
  end
end
