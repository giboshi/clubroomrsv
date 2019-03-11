class CirclesController < ApplicationController
  before_action :require_circle_logged_in, only: [:index]
  def index
    @circles = Circle.page(params[:page])
  end

  def show
    #@circle = Circle.find(params[:id])
    #@items = @user.items.uniq
    #@count_want = @circle.reserved_rooms.count
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)

    if @circle.save
      flash[:success] = 'サークルを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'サークルの登録に失敗しました。'
      render :new
    end
  end
  
  def reservations
    @circle = Circle.find(params[:id])
    #@reservationings = @circle.reservationings.page(params[:page])
    #@room = Room.find(params[:id])
    @re_rooms = @circle.reserved_rooms.page(params[:page])
  end
  
  private

  def circle_params
    params.require(:circle).permit(:name, :password, :password_confirmation)
  end
end
