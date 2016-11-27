module V1
  class IdentitiesController < ApplicationController
    expose(:identity, scope: -> { current_user.identities })

    def destroy
      identity.destroy!
      respond_with nothing: true, status: 200
    end
  end
end
