require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  header "Content-Type", "application/json"
  post "api/v1/users" do
    parameter :first_name, "First name of user", scope: :user, required: true
    parameter :last_name, "Last name of user", scope: :user, required: true
    parameter :email, "email id of user", scope: :user, required: true
    parameter :mobile, "email id of user", scope: :user, required: true
    parameter :password, "password for user", scope: :user, required: true
    context "valid request" do
      let(:user) { build(:user) }
      let(:first_name) { user.first_name }
      let(:last_name) { user.last_name }
      let(:email) { user.email }
      let(:mobile) { user.mobile }
      let(:password) { user.password }
      let(:raw_post) { params.to_json }

      example_request "Sign up user request [valid]" do
        explanation " Sign up a new user to the system"
        expect(status).to eq 201
      end
    end
    context "invalid request" do
      let(:user) { create(:user) }
      let(:first_name) { user.first_name }
      let(:last_name) { user.last_name }
      let(:email) { user.email }
      let(:mobile) { user.mobile }
      let(:password) { user.password }
      let(:raw_post) { params.to_json }

      example_request "Sign up user request [invalid]" do
        explanation "Signup request for the existing user"
        expect(status).to eq 422
      end
    end
  end

  post "/api/v1/user/signin" do
    parameter :email, "email id of the registered user", scope: :user, required: true
    parameter :password, "password of the user", scope: :user, required: true
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:raw_post) { params.to_json }

    example_request "Generate authentication token request" do
      explanation "Sign in and generate token with email and password"

      expect(status).to eq 200
      response_json = JSON.parse(response_body)
      expect(response_json['token']).not_to eq nil
    end
  end
end