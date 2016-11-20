class UpdateUser
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.fail! unless user.update_with_password(params)
  end

  private

  def passwords_blank?
    user_params[:password].blank? && user_params[:password_confirmation].blank?
  end

  def params
    if passwords_blank?
      user_params.except(:password, :password_confirmation)
    else
      user_params
    end
  end
end
