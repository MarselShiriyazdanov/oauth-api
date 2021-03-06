require "rails_helper"

describe FindUserByEmail do
  let(:interactor) { described_class.new(auth: auth_hashie) }

  subject(:find_user_by_email) { interactor.call }

  context "when user not exists" do
    it { is_expected.to be_nil }
  end

  context "when user exists" do
    let!(:user) { create(:user, :from_auth_hashie, confirmed_at: nil) }

    it "creates new identity" do
      expect { find_user_by_email }.to change { user.identities.count }.by(1)
      expect(subject).to eq(user)
    end

    it "confirms user" do
      expect(user.confirmed?).to be_falsey
      find_user_by_email
      expect(user.reload.confirmed?).to be_truthy
    end
  end
end
