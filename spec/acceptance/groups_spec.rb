require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource "Groups" do
  header "Content-Type", "application/json"
  let(:user) { create(:user, email: 'test@example.com', password: 'password123') }
  post 'api/v1/groups' do
    parameter :name, 'Name of the group', scope: :group, required: true
    parameter :description, 'Description for the group', scope: :group, required: true
    before do
      generate_token_and_set_header user
    end
    context "valid request" do
      let(:group) { build(:group) }
      let(:name) { group.name }
      let(:description) { group.description }
      let(:raw_post) { params.to_json }

      example_request "Create a new group [valid]" do
        explanation "Create a new Group"
        p response_body
        expect(status).to eq 201

      end
    end
  end

  get 'api/v1/groups/:id' do
    let(:group) { create(:group, members_count: 2) }
    let(:id) { group.id}
    before { generate_token_and_set_header user }
    example_request 'Get Group information' do
      explanation 'To get the complete information about the group'
      #p response_body
      expect(status).to eq 200
    end
  end

  delete 'api/v1/groups/:id' do
    let(:group) { create(:group, members_count: 2) }

    context 'admin user' do
      let!(:user_admin) { create(:member, user: user, group: group,role: :admin )}
      let(:id) { group.id}
      before {
        generate_token_and_set_header user }
      example_request 'Delete Group' do
        explanation 'To delete the group, only admin of the group can delete the group'
        expect(status).to eq 200
      end
    end
    context 'non admin user' do

      let(:id) { group.id}
      before {
        generate_token_and_set_header user }
      example_request 'Delete Group' do
        explanation 'Deleting the group - member/ others can''t delete'

        expect(status).to eq 401
      end
    end

  end

end
