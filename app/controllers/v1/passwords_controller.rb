module V1
  class PasswordsController < ApplicationController
    def update
      current_user.update(password_params)

      respond_with current_user
    end

    private

    def password_params
      params.permit(:password, :password_confirmation).merge(reset_password_token: nil)
    end
  end
end
