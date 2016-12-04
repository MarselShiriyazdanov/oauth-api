require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Omniauth Callbacks" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  before do
    OmniAuth.config.mock_auth[:facebook] = auth_hashie
  end

  get "/users/auth/:provider/callback" do
    header "X-User-Email", "user@example.com"

    parameter :provider, "Provider", required: true

    let!(:user) { create :user, email: "user@example.com", authentication_token: "token" }
    let(:provider) { "facebook" }

    context "when token is not set" do
      header "X-User-Token", ""

      let(:interactor) { double("Context", user: user) }

      example "Create new identity" do
        expect(FetchOauthUser).to receive(:call).and_return(interactor)
        do_request

        expect(response_status).to eq 200
        expect(response["user"]).to be_a_session_representation
      end
    end

    context "when token present" do
      header "X-User-Token", "token"

      example "Connect identity" do
        expect(ConnectIdentity).to receive(:call)
        do_request

        expect(response_status).to eq 200
        expect(response["user"]).to be_a_session_representation
      end
    end

    context "when email not verified" do
      before do
        OmniAuth.config.mock_auth[:facebook] = auth_hashie(verified: false)
      end

      example_request "User email is not verified" do
        expect(response_status).to eq 403
      end
    end
  end
end
