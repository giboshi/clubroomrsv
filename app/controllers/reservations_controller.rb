class ReservationsController < ApplicationController
  def index
    #@reservations = Reservation.all.page(params[:page])
    @reservations = current_circle.reservations.order('created_at DESC')
    #binding.pry
  end
  def new
    # @room = Room.find(params[:id])
    # @rooms = Room.all
    @reservation = Reservation.new
  end
  
  def create
    #require 'date'
    #@reservation = Reservation.new(reservation_params)
    @reservation = current_circle.reservations.build(reservation_params)
    #room = Room.find(params[:reservation][:room_id])
    #room = params[:reservation][:room_id]
    #@reserved_from_at_date = params[:reservation][:reserved_from_at_date]
    #@reserved_from_at_hour = params[:reservation][:reserved_from_at_hour]
    #@reserved_from_at_minute = params[:reservation][:reserved_from_at_minute]
    #@reserved_to_at_date = params[:reservation][:reserved_to_at_date]
    #@reserved_to_at_hour = params[:reservation][:reserved_to_at_hour]
    #@reserved_to_at_minute = params[:reservation][:reserved_to_at_minute]
    #@staff = params[:reservation][:staff]
    #@memo = params[:reservation][:memo]
    # current_circle.reservation(room)
    
    #@reservation = current_circle.reservations.build({
     # room_id: room.id,
     #reserved_from_at: @reserved_from_at,
      #reserved_from_at_date: @reserved_from_at_date,
      #reserved_from_at_hour: @reserved_from_at_hour,  
      #reserved_from_at_minute: @reserved_from_at_minute,
      #reserved_to_at_date: @reserved_to_at_date,
      #reserved_to_at_hour: @reserved_to_at_hour,
      #reserved_to_at_minute: @reserved_to_at_minute,
      #staff: @staff,
      #memo: @memo,
    #})
    #@reservation.save!
    require 'date'
    _datetime_reserved_from_at = params[:reservation][:reserved_from_at_date]
    _datetime_reserved_from_at = _datetime_reserved_from_at.to_date
    _datetime_reserved_to_at = params[:reservation][:reserved_to_at_date]
    _datetime_reserved_to_at = _datetime_reserved_to_at.to_date
    _reserved_from_at = DateTime.new( _datetime_reserved_from_at.year,  _datetime_reserved_from_at.month,  _datetime_reserved_from_at.day, (params[:reservation][:reserved_from_at_hour]).to_i, (params[:reservation][:reserved_from_at_minute]).to_i)
    #_reserved_from_at = @reservation.reserved_from_at
    _reserved_to_at = DateTime.new( _datetime_reserved_to_at.year,  _datetime_reserved_to_at.month,  _datetime_reserved_to_at.day, (params[:reservation][:reserved_to_at_hour]).to_i, (params[:reservation][:reserved_to_at_minute]).to_i)
    #_reserved_to_at = DateTime.parse.new(params[:reservation][:reserved_to_at_date].year, params[:reservation][:reserved_to_at_date].month, params[:reservation][:reserved_to_at_date].day, params[:reservation][:reserved_to_at_hour], params[:reservation][:reserved_to_at_minute])
    #binding.pry
    #@reservation.destroy
    #_reserved_from_at = params[:reservation][:reserved_from_at]
    #_reserved_to_at = params[:reservation][:reserved_to_at]
    _count_reservations = counts(current_room)
    _count1 = bookingtest1(_reserved_from_at) #X_b≦Y_b≦X_e
    #_count2 = bookingtest2(_reserved_from_at) #Y_b≦X_e
    _count2 = bookingtest2(_reserved_to_at) #X_b≦Y_e≦X_e
    #_count4 = bookingtest4(_reserved_to_at) #Y_e≦X_e
    _count3 = bookingtest3(_reserved_from_at, _reserved_to_at) #Y_b≦X_bかつX_e≦Y_e
    #_count6 = bookingtest6(_reserved_to_at) #X_e≦Y_e
    binding.pry
    
    if (_count1 != 0)  #X_b≦Y_b≦X_e
      flash[:danger] = '予約できません。'
      redirect_to root_url and return 
      #break
    else
      if (_count2 != 0)  #X_b≦Y_e≦X_e
        flash[:danger] = '予約できません。'
        redirect_to root_url and return 
      else
        if (_count3 != 0)  #Y_b≦X_bかつX_e≦Y_e
          flash[:danger] = '予約できません。'
          redirect_to root_url and return 
          #break
        else
          @reservation.save!
          flash[:success] = '予約しました。'
          redirect_to root_url
        end
      end
    end
  
  end

  #def destroy
   # room = Room.find(params[:reservation][:room_id])
    #current_circle.unreservation(room)
    #flash[:success] = '予約を解除しました。'
    #redirect_to circle
  #end
  
  #def reservationings
    #@circle = Circle.find(params[:id])
    #@reservationings = @circle.reservationings.page(params[:page])
    #@room = Room.find(params[:id])
    #@reserved_rooms = @room.reservationings.page(params[:page])
#  end
  
  def current_circle
    @current_circle ||= Circle.find_by(id: session[:circle_id])
  end
  
  def current_room
    @current_room ||= Room.find_by(id: params[:reservation][:room_id])
  end
  
  def counts(current_room)
    _count_reservations = current_room.reservations.count
    return _count_reservations
  end
  
  def bookingtest1(_reserved_from_at) #X_b≦Y_b≦X_e
    _count = 0
    @reservations = current_room.reservations.order('created_at DESC')
    @reservations.each do |reservation|
      _f = reservation.reserved_from_at
      _m = _reserved_from_at
      _l = reservation.reserved_to_at
      if (_m.to_i - _f.to_i >= 0) and (_l.to_i - _m.to_i >= 0)
        _count += 1
      end
    end
    return _count
  end
  
  #def bookingtest2(_reserved_from_at) #Y_b≦X_e
   # _count = 0
    #@reservations = current_room.reservations.order('created_at DESC')
    #@reservations.each do |reservation|
     # _start = _reserved_from_at
      #_end = reservation.reserved_to_at
      #if _end.to_i - _start.to_i >= 0
       # _count += 1
      #end
    #end
    #return _count
  #end
  
  def bookingtest2(_reserved_to_at) #X_b≦Y_e≦X_e
    _count = 0
    @reservations = current_room.reservations.order('created_at DESC')
    @reservations.each do |reservation|
      _f = reservation.reserved_from_at
      _m = _reserved_to_at
      _l = reservation.reserved_to_at
      if (_m.to_i - _f.to_i >= 0) and (_l.to_i - _m.to_i >= 0)
        _count += 1
      end
    end
    return _count
  end
  
  #def bookingtest4(_reserved_to_at) #Y_e≦X_e
   # _count = 0
    #@reservations = current_room.reservations.order('created_at DESC')
    #@reservations.each do |reservation|
     # _start = _reserved_to_at
      #_end = reservation.reserved_to_at
      #if _end.to_i - _start.to_i >= 0
       # _count += 1
      #end
    #end
    #return _count
  #end
  
  def bookingtest3(_reserved_from_at, _reserved_to_at) #Y_b≦X_bかつX_e≦Y_e
    _count = 0
    @reservations = current_room.reservations.order('created_at DESC')
    @reservations.each do |reservation|
      _fb = _reserved_from_at
      _lb = reservation.reserved_from_at
      _fe = reservation.reserved_to_at
      _le = _reserved_to_at
      if (_lb.to_i - _fb.to_i >= 0) and (_le.to_i - _fe.to_i >= 0)
        _count += 1
      end
    end
    return _count
  end
  
  #def bookingtest6(_reserved_to_at) #X_e≦Y_e
   # _count = 0
    #@reservations = current_room.reservations.order('created_at DESC')
    #@reservations.each do |reservation|
     # _start = reservation.reserved_to_at
      #_end = _reserved_to_at
      #if _end.to_i - _start.to_i >= 0
       # _count += 1
      #end
    #end
    #return _count
  #end
  
  private

  def reservation_params
    params.require(:reservation).permit(:id, :room_id, :circle_id, :reserved_from_at_date, :reserved_from_at_hour, :reserved_from_at_minute, :reserved_to_at_date, :reserved_to_at_hour, :reserved_to_at_minute, :staff, :memo)
  end
end
