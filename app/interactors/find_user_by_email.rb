class FindUserByEmail
  include Interactor

  delegate :auth, to: :context

  def call
    return unless user

    create_identity
    user.confirm unless user.confirmed?
    context.user = user
  end

  private

  def user
    @user ||= User.find_by(email: auth.info.email)
  end

  def create_identity
    user.identities.where(provider: auth.provider, uid: auth.uid).first_or_create!
  end
end
