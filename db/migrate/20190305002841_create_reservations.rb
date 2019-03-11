class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :room, foreign_key: true
      t.references :circle, foreign_key: true
      t.datetime :reserved_from
      t.datetime :reserved_to
      t.string :staff
      t.string :memo

      t.timestamps
    end
  end
end
