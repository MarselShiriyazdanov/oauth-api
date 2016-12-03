class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  before_action :set_token, if: :current_user

  acts_as_token_authentication_handler_for User, fallback: :none

  respond_to :json

  def devise_parameter_sanitizer
    if resource_class == User
      ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  # sets authentication_token so we can share DB between react and non-react version
  # demo purposes only
  def set_token
    current_user.update(:authentication_token, Devise.friendly_token) unless current_user.authentication_token
  end
end
