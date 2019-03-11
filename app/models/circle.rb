class Circle < ApplicationRecord
  validates :name, presence: true
  has_secure_password
  
  has_many :rooms
  has_many :reservations
  has_many :reserved_rooms, through: :reservations, source: :room
  
  #def reservation(room)
   # self.reservations.find_or_create_by(room_id: room.id)
  #end
  
  #def unreservation(room)
   # reservation = self.reservations.find_by(room_id: room.id)
    #reservation.destroy if reservation
  #end
  
  #def reservationing?(room)
   # self.reserved_rooms.include?(room)
  #end
end

  