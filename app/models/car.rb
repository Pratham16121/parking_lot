class Car < ApplicationRecord
  has_many :tickets
  validates :registration, uniqueness: true
  attr_accessor :is_parked
end
