class Slot < ApplicationRecord
  belongs_to :ticket, optional: true
end
