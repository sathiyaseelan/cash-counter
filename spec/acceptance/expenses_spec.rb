require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Expenses" do
  header "Content-Type", "application/json"
  let(:user) { create(:user, email: 'test@example.com', password: 'password123') }
  let(:group) { create(:group, :with_members, :with_admins) }

  post 'api/v1/groups/:group_id/expenses' do
    parameter :amount, 'Amount of the Expense', scope: :expense, required: true
    parameter :description, 'Description for the group', scope: :expense, required: true
    parameter :categories, 'List of categories', scope: :expense, required: true
    parameter :paid_by_id, 'Id of the user paid', scope: :expense, required: true
    parameter :paid_on, 'Paid date', scope: :expense, required: true

    before { generate_token_and_set_header user }

    context "valid request" do
      let(:group_id) { group.id }
      let(:amount) { 200.50 }
      let(:description) { 'Bought meat' }
      let(:categories) { ['food', 'grocery'] }
      let(:paid_by_id) { group.members.first.id }
      let(:paid_on) { Time.now }
      let(:raw_post) { params.to_json }

      example_request "Create a new expense [valid]" do
        explanation "Create a new expense"
        p response_body
        expect(status).to eq 201
      end
    end
  end

  get 'api/v1/groups/:group_id/expenses' do

    before { generate_token_and_set_header user }
    let!(:expense1){ create(:expense, :with_common_categories, :with_group_categories, group: group, paid_by: group.members.first, categories_count: 3) }
    context "valid request" do

      let(:group_id) { group.id }
      example_request "get all expenses for the group [valid]" do
        explanation "Get all the expense for the group"
        p response_body
        expect(status).to eq 200
      end
    end
  end
end
