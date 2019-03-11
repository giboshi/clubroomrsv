class AddreservedToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :reserved_from_at_date, :datetime
    add_column :reservations, :reserved_from_at_hour, :datetime
    add_column :reservations, :reserved_from_at_minute, :datetime
    add_column :reservations, :reserved_to_at_date, :datetime
    add_column :reservations, :reserved_to_at_hour, :datetime
    add_column :reservations, :reserved_to_at_minute, :datetime
  end
end
