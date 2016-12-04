RSpec::Matchers.define :be_a_user_profile_representation do
  match do |json|
    response_attributes = %w(
      id
      email
      identities
      first_name
      last_name
      gender
      current_password
      password
      password_confirmation
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
