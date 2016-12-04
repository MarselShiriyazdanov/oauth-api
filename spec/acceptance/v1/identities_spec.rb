require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Identities" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  delete "/v1/identities/:id" do
    header "X-User-Email", "user@example.com"
    header "X-User-Token", "token"

    parameter :id, "Id", required: true

    let(:user) { create :user, email: "user@example.com", authentication_token: "token" }
    let!(:identity) { create :identity, user: user, provider: "facebook" }
    let(:id) { identity.id }

    example "Remove identity" do
      expect { do_request }.to change { Identity.count }.by(-1)

      expect(response_status).to eq 200
    end
  end
end
