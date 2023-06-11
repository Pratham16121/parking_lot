class Car < ApplicationRecord
  has_many :tickets
  validates :registration, uniqueness: true
end
