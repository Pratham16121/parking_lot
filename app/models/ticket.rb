class Ticket < ApplicationRecord
  belongs_to :slot, foreign_key: "assigned_slot"
  after_save :fill_slot, unless: :is_deleted?
  after_update :empty_slot, if: :is_deleted?

  private

  def fill_slot
    self.slot.update!(is_empty: false)
  end

  def empty_slot
    self.slot.update!(is_empty: true)
  end
end