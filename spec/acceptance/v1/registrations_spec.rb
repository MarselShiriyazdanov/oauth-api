require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Registrations" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/users/sign_up" do
    parameter :email, "Email", required: true
    parameter :password, "Password", required: true
    parameter :password_confirmation, "Password confirmation", required: true

    let(:email) { "user@example.com" }
    let(:password) { "123456" }
    let(:password_confirmation) { password }

    example "Sign up with valid params" do
      do_request

      expect(response_status).to eq 201
      expect(response["user"]).to be_a_session_representation
    end

    example_request "Sign up with invalid params", email: "" do
      expect(response_status).to eq 422
    end
  end
end
