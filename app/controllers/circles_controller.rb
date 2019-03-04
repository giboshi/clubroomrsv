class CirclesController < ApplicationController
  def index
    @circles = Circle.page(params[:page])
  end

  def show
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
  
  private

  def circle_params
    params.require(:circle).permit(:name, :password, :password_confirmation)
  end
end
