module Slots
  class Index
    def initialize
    end
    def call
      slots = Slot.select(:id, :name, :distance, :is_empty, :ticket_id).order(:id)
    end
  end
end