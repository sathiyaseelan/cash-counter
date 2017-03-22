require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource "Members" do
  header "Content-Type", "application/json"
  let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

  post 'api/v1/groups/:group_id/members' do
    parameter :user_email, 'email of new user',  required: true
    parameter :user_id, 'id of existing user',  required: true
    parameter :role, 'role of the user in the user (member/ admin) - default: member', required: false

    let(:group) { create(:group,:with_members, :with_admins, members_count: 2) }
    let(:group_id) { group.id}
    context 'known user' do

      let(:user_id) { user.id}
      let(:raw_post) { params.to_json }
      before { generate_token_and_set_header user }

      example_request 'Add already known member to the group' do
        explanation 'To add a person(already related) member to the group'

        expect(status).to eq 200
        response_json = JSON.parse(response_body)
        expect(response_json['data']['id']).not_to eq nil
        expect(response_json['data']['role']).to eq 'member'
      end

      context 'admin' do
        let(:role) { 'admin' }

        example_request 'Add already known member to the group as admin' do
          explanation 'To add a person(already related) member to the group as admin'

          expect(status).to eq 200
          response_json = JSON.parse(response_body)
          expect(response_json['data']['id']).not_to eq nil
          expect(response_json['data']['role']).to eq 'admin'
        end

      end
    end

    context 'unknown user' do
      let(:user_email) { Faker::Internet.email}
      let(:raw_post) { params.to_json }
      before { generate_token_and_set_header user }
      example_request 'Add unknown member to the group' do
        explanation 'To add new person member to the group'
        p params.to_json
        p response_body
        pending
        expect(status).to eq 200
      end
    end
  end

  delete 'api/v1/groups/:group_id/members/:id' do
    let(:group) { create(:group,:with_members, :with_admins, members_count: 2,admins_count: 2) }
    let(:group1) {create(:group,:with_members, :with_admins, members_count: 2)}
    let(:group_id) { group.id}

    before { generate_token_and_set_header user }
    context 'member' do
      let(:id) { group.members.first.id }
      example_request 'Delete a member of the group' do
        expect(status).to eq 200
      end
    end
    context 'admin' do
      let(:id) { group.admins.first.id }
      example_request 'Delete a admin of the group' do
        expect(status).to eq 200
      end
      context 'only one admin' do
        let(:group_id) {group1.id}
        let(:id) { group1.admins.last.id }
        example_request 'Delete only admin of the group' do
          expect(status).to eq 422
        end
      end
    end
  end

  put 'api/v1/groups/:group_id/members/:id' do
    let(:group) { create(:group,:with_members, :with_admins, members_count: 2,admins_count: 1) }
    let(:group_id) { group.id}

    before { generate_token_and_set_header user }
    example 'Change member to admin' do
      id = group.members.first.id
      do_request
    end

    example 'Change admin to member' do
      id = group.admins.first.id
      do_request
    end
  end
end
