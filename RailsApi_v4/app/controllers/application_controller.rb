class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  protect_from_forgery with: :null_session#, if: Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter  :verify_authenticity_token
  skip_before_filter :authenticate_user!

end
