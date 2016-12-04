require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Password" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  put "/v1/passwords" do
    header "X-User-Email", "user@example.com"
    header "X-User-Token", "token"

    parameter :password, "Password", required: true
    parameter :password_confirmation, "Password confirmation", required: true

    let!(:user) { create :user, email: "user@example.com", authentication_token: "token", reset_password_token: "t" }
    let(:password) { "123456" }
    let(:password_confirmation) { password }

    example "Set password" do
      do_request

      expect(User.last.reset_password_token).to eq(nil)
      expect(response_status).to eq 200
    end
  end
end
