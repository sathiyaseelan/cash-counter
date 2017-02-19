  require 'rails_helper'

RSpec.describe 'User Signup request', type: :request do

  context 'public request with valid attributes' do
    it 'allow user to sign up' do
      byebug
      byebug
      user_attributes = attributes_for :user
      user_params = build_json_for attributes: user_attributes, root: :user
      post_json url: users_path, params: user_params
      expect(response.status).to eq 201
      expect(response_value('success')).to eq true
      expect(response_value('data','email')).to eq user_attributes[:email]
    #  expect(response_value('data','token')).not_to eq nil
    end
  end

  context 'public request with invalid attributes' do
    it 'does not allow user to signup with email alreay registered' do
      user_attributes = attributes_for :user
      existing_user = create(:user, user_attributes)

      user_params = build_json_for attributes: user_attributes, root: :user
      post_json url: users_path, params: user_params
      expect(response.status).to eq 422
      byebug
      expect(response_value('success')).to eq false
      expect(response_value('data','email')).to eq user_attributes[:email]

    end
  end
end
