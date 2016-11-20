module V1
  class UsersController < ApplicationController
    def me
      respond_with current_user, serializer: ProfileSerializer
    end

    def update
      if UpdateUser.call(user: current_user, user_params: user_params).success?
        respond_with current_user, serializer: ProfileSerializer, status: 200
      else
        respond_with current_user, serializer: ProfileSerializer, status: 500
      end
    end

    private

    def user_params
      params.permit(
        :email,
        :first_name,
        :last_name,
        :gender,
        :current_password,
        :password,
        :password_confirmation
      )
    end
  end
end
