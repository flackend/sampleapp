module SessionsHelper

  def sign_in(user)
    # Add user's remember token to session.
    session[:remember_token] = user.remember_token
    # Set user as current_user.
    self.current_user = user
  end

  def signed_in?
    ! current_user.nil?
  end

  def sign_out
    reset_session
    self.current_user = nil
  end

  def current_user=(u)
    # Setter for curent_user.
    @current_user = u
  end
  
  def current_user
    # Getter. Returns current_user of finds user that matches the session
    # remember token.
    #
    # NOTICE! Witout the if statement, after a user logs out, the first user
    # with a nil remember token will automatically be logged in!
    if session[:remember_token]
      @current_user ||= User.find_by_remember_token session[:remember_token]
    end
  end	
end