class AddIntegratereservedToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :reserved_from_at, :datetime
    add_column :reservations, :reserved_to_at, :datetime
  end
end
