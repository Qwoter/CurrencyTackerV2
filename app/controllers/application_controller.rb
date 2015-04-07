class ApplicationController < ActionController::Base
  protect_from_forgery
  # We don't use this cool rails feature to verify token parameter from client side form request so we disable it.
  skip_before_filter :verify_authenticity_token
end
