require "rails_helper"

describe ProfileSerializer do
  let(:user) { build :user, id: 1, authentication_token: "token" }
  let(:json) { ActiveModel::SerializableResource.serialize(user, serializer: described_class).to_json }
  let(:user_json) { parse_json(json)["user"] }

  it "returns user" do
    expect(user_json).to be_a_user_profile_representation(user)
  end

  it "returns empty password strings" do
    expect(user_json["current_password"]).to eq("")
    expect(user_json["password"]).to eq("")
    expect(user_json["password_confirmation"]).to eq("")
  end
end
