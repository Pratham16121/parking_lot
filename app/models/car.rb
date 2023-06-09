class Car < ApplicationRecord
  validates :registration, uniqueness: true
end
