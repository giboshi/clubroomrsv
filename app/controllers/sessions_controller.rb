class SessionsController < ApplicationController
  def new
    #@circle = Circle.find(params[:circle_id])
  end

  def create
    name = params[:session][:name].downcase
    password = params[:session][:password]
    if login(name,password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:circle_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private

  def login(name, password)
    @circle = Circle.find_by(name: name)
    if @circle && @circle.authenticate(password)
      # ログイン成功
      session[:circle_id] = @circle.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
