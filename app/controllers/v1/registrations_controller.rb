module V1
  class RegistrationsController < Devise::RegistrationsController
    wrap_parameters :user

    def create
      user = User.create(sign_up_params)

      respond_with user, serializer: SessionSerializer
    end
  end
end
