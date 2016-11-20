class ProfileSerializer < UserSerializer
  attributes :first_name, :last_name, :gender

  %i(current_password password  password_confirmation).each do |attr|
    attribute attr

    define_method attr do
      ""
    end
  end
end
