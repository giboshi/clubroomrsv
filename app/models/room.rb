class Room < ApplicationRecord
  belongs_to :circle, optional: true
  has_many :reservations
end
