module SessionsHelper
  def current_circle
    @current_circle ||= Circle.find_by(id: session[:circle_id])
  end

  def logged_in?
    !!current_circle
  end
end
