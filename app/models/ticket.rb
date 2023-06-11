class Ticket < ApplicationRecord
  belongs_to :car
  belongs_to :slot, foreign_key: "assigned_slot"
  after_save :fill_slot, unless: :is_deleted?
  after_update :empty_slot, if: :is_deleted?
  validate :validate_unique_active_ticket, on: :create

  private

  def fill_slot
    self.slot.update!(is_empty: false, ticket_id: self.id)
  end

  def empty_slot
    self.slot.update!(is_empty: true, ticket_id: nil)
  end

  def validate_unique_active_ticket
    if Ticket.exists?(car_id: car_id, is_deleted: false)
      errors.add(:base, 'Only one active ticket is allowed per car')
    end
  end

end
