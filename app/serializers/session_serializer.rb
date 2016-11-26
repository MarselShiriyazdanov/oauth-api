class SessionSerializer < UserSerializer
  attributes :authentication_token, :reset_password_token
end
