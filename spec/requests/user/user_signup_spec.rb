require 'rails_helper'

RSpec.describe 'User Signup request', type: :request do

  context 'public request with valid attributes' do
    it 'allow user to sign up' do
      user_params = build_json_for :user
      post_json users_path, params: user_params
      expect(response.status).to eq 201
      expect(response_value('success')).to eq true
    end
  end
end
