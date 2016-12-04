class UpdateUser
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.fail! unless user.update_with_password(user_params)
  end
end
