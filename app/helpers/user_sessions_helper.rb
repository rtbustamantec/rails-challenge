module UserSessionsHelper
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def log_out
    current_user_session.destroy
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def not_authorized
    unless logged_in?
      redirect_to root_path
    end
  end

  def not_authenticated
    redirect_to profile_path if logged_in?
  end
end
