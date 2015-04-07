class ApplicationController < ActionController::Base
  protect_from_forgery
  # We don't use this cool rails feature to verify token parameter from client side form request so we disable it.
  skip_before_filter :verify_authenticity_token

  private
    def authenticate
      api_key = request.headers['X-Api-Key']
      @user = User.where(api_key: api_key).first if api_key
     
      unless @user
        head status: :unauthorized
        return false
      end
    end
end
