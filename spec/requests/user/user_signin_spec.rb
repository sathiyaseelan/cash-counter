require 'rails_helper'

RSpec.describe 'Signin Request', type: :request do

  context 'with valid user name and password' do
    it ' returns the valid token for user' do
      user_attributes = attributes_for :user
      existing_user = create(:user, user_attributes)
      login_attributes = user_attributes.extract!(:email, :password)
      login_params = build_json_for attributes: login_attributes, root: :user
      post_json url: signin_path, params: login_params
      expect(response.status).to eq 200

      expect(response_value('success')).to eq true
      expect(response_value('token')).not_to eq nil
    end
  end

  context 'with invalid user name and password' do
    it ' doesnot return the token for user' do
      user_attributes = attributes_for :user
      existing_user = create(:user, user_attributes)

      invalid_attributes = attributes_for :user

      login_attributes = invalid_attributes.extract!(:email, :password)
      login_params = build_json_for attributes: login_attributes, root: :user
      post_json url: signin_path, params: login_params
      expect(response.status).to eq 401

      expect(response_value('success')).to eq false
      expect(response_value('token')).to eq nil
      expect(response_value['messages']).to include 'Invalid email / password'
    end
  end
end
