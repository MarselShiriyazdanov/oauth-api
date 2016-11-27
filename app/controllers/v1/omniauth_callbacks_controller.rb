module V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    acts_as_token_authentication_handler_for User, only: []

    def google_oauth2
      if auth_verified?
        current_user ? connect_identity : process_sign_in
        respond_with current_user, serializer: SessionSerializer
      else
        render nothing: true, status: 403
      end
    end

    private

    def current_user
      @current_user ||= User.find_by(authentication_token: request.headers["X-User-Token"])
    end

    def auth_verified?
      AuthVerificationPolicy.new(auth).verified?
    end

    def auth
      request.env["omniauth.auth"]
    end

    def connect_identity
      ConnectIdentity.call(user: current_user, auth: auth)
    end

    def process_sign_in
      @current_user = FetchOauthUser.call(auth: auth).user
    end
  end
end
