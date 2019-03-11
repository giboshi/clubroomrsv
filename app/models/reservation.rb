# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :circle
  
  #class Form::Product < Product
  include DatetimeIntegratable

  #REGISTRABLE_ATTRIBUTES = %i(
   # reserved_from_at_date reserved_from_at_hour reserved_from_at_minute
  #)

  # DatetimeIntegratableで宣言した、 integrate_datetime_fields関数を利用
  # 下記のように宣言することで、モデル初期化時にreserved_from_atを
  # reserved_from_at_date, reserved_from_at_hour, reserved_from_at_minute に分解する
  #
  # モデル保存時に、date/hour/minute の3つの変数の値を
  # reserved_from_at に戻す
  integrate_datetime_fields :reserved_from_at, :reserved_to_at

  validates :reserved_from_at_date, presence: true
  validates :reserved_from_at_hour, presence: true
  validates :reserved_from_at_minute, presence: true
  

  validates :reserved_to_at_date, presence: true
  validates :reserved_to_at_hour, presence: true
  validates :reserved_to_at_minute, presence: true
end
