require "rails_helper"

describe FetchOauthUser do
  let(:interactor) { described_class.new(auth: auth_hashie) }

  subject(:fetched_user) { interactor.call }

  context "when identity exists" do
    let!(:identity) { create(:identity, uid: auth_hashie.uid, provider: auth_hashie.provider) }

    it { is_expected.to eq(identity.user) }
  end

  context "when identity not exists" do
    context "when user exists" do
      let(:user) { build(:user) }
      let(:context) { Hashie::Mash.new(user: user) }

      before do
        allow(FindUserByEmail).to receive(:call).and_return(context)
      end

      it "fetches user by email" do
        expect(FindUserByEmail).to receive(:call)
        expect(fetched_user).to eq(user)
      end
    end

    context "when user not exists" do
      let(:user) { build(:user) }
      let(:context) { Hashie::Mash.new(user: user) }

      before do
        allow(CreateUserFromAuth).to receive(:call).and_return(context)
      end

      it "creates new one" do
        expect(CreateUserFromAuth).to receive(:call)
        expect(fetched_user).to eq(user)
      end
    end
  end
end
