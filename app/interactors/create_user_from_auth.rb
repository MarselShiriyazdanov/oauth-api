class CreateUserFromAuth
  include Interactor

  delegate :auth, to: :context

  def call
    user = User.new(user_params)
    user.skip_confirmation!
    user.save!
    context.user = user
  end

  private

  def user_params
    {
      email: auth.info.email,
      first_name: first_name,
      last_name: last_name,
      gender: auth.extra.raw_info.gender,
      password: password,
      password_confirmation: password,
      reset_password_token: Time.now.to_i
    }
  end

  def password
    @password ||= Devise.friendly_token.first(8)
  end

  def first_name
    auth.info.first_name || auth.extra.raw_info.first_name
  end

  def last_name
    auth.info.last_name || auth.extra.raw_info.last_name
  end
end
