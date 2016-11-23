class FetchOauthUser
  include Interactor

  delegate :auth, to: :context

  def call
    context.user = user_found_by_uid || user_found_by_email || new_user
  end

  private

  def user_found_by_uid
    Identity.from_omniauth(auth)&.user
  end

  def user_found_by_email
    FindUserByEmail.call(auth: auth).user
  end

  def new_user
    CreateUserFromAuth.call(auth: auth).user
  end
end
