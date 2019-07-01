class ApplicationController < ActionController::Base
  include Pundit 
  protect_from_forgery 
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :encrypted_password, :remember_me, :login, :user]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end