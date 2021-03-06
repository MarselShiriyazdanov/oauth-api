require "rails_helper"

describe AuthVerificationPolicy do
  let(:auth) { OmniAuth::AuthHash.new provider: provider, info: {}, extra: {} }

  describe ".verified?" do
    subject { described_class.new(auth).verified? }

    context "when provider is Facebook" do
      let(:provider) { "facebook" }

      before do
        allow(auth).to receive_message_chain(:info, :verified?).and_return(true)
        allow(auth).to receive_message_chain(:extra, :raw_info, :verified?).and_return(true)
      end

      it "returns corresponding value" do
        expect(subject).to eq(true)
      end
    end

    context "when provider is Google" do
      let(:provider) { "google_oauth2" }

      before do
        allow(auth).to receive_message_chain(:extra, :raw_info, :email_verified?).and_return(true)
      end

      it "returns corresponding value" do
        expect(subject).to eq(true)
      end
    end

    context "when provider checking is not defined" do
      let(:provider) { "another" }

      it "raises Exception" do
        expect { subject }
          .to raise_error(
            AuthVerificationPolicy::OauthError,
            I18n.t("omniauth.verification.not_implemented", kind: provider)
          )
      end
    end
  end
end
