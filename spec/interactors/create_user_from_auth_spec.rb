require "rails_helper"

describe CreateUserFromAuth do
  let(:user) { User.last }
  let(:interactor) { described_class.new(auth: auth_hashie) }
  let(:sent_emails) { ActionMailer::Base.deliveries.count }

  subject { interactor.call }

  it "creates new confirmed user from auth hash" do
    expect { subject }.to change { User.count }.by(1)
    expect(sent_emails).to eq(0)
    expect(user.email).to eq(auth_hashie.info.email)
    expect(user.first_name).to eq(auth_hashie.info.first_name)
    expect(user.confirmed?).to be_truthy
  end
end
