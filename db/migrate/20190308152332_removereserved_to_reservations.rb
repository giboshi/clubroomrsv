class RemovereservedToReservations < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :reserved_from
    remove_column :reservations, :reserved_to
  end
end
