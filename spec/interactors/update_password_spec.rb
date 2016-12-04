require "rails_helper"

describe UpdateUser do
  let(:interactor) { described_class.new(user: user, user_params: params) }
  let(:context) { interactor.context }
  let(:user) { create(:user, password: "123456") }

  before do
    interactor.run
  end

  context "when password blank and current_password valid" do
    let(:params) { { first_name: "Fname", current_password: "123456" } }

    it "updates user" do
      expect(user.reload.first_name).to eq("Fname")
    end

    it "interactor succeed" do
      expect(context).to be_success
    end
  end

  context "when password blank and current_password is invalid" do
    let(:params) { { last_name: "Lname", current_password: "" } }

    it "does not updates user" do
      expect(user.reload.last_name).not_to eq("Lname")
    end

    it "interactor fails" do
      expect(context).to be_failure
    end
  end

  context "when password, password_confirmation and current_password is valid" do
    let(:new_password) { "12345678" }
    let(:params) do
      { last_name: "Last", current_password: "123456", password: new_password, password_confirmation: new_password }
    end

    it "updates user" do
      expect(user.reload.last_name).to eq("Last")
    end

    it "interactor succeed" do
      expect(context).to be_success
    end
  end

  context "when password, password_confirmation is valid and current_password is not valid" do
    let(:new_password) { "12345678" }
    let(:params) do
      { last_name: "Last2", current_password: "", password: new_password, password_confirmation: new_password }
    end

    it "does not updates user" do
      expect(user.reload.last_name).not_to eq("Last2")
    end

    it "interactor fails" do
      expect(context).to be_failure
    end
  end

  context "when password, password_confirmation is invalid and current_password is valid" do
    let(:new_password) { "12345678" }
    let(:params) do
      { last_name: "Last3", current_password: "123456", password: new_password, password_confirmation: "" }
    end

    it "does not updates user" do
      expect(user.reload.last_name).not_to eq("Last3")
    end

    it "interactor fails" do
      expect(context).to be_failure
    end
  end
end
