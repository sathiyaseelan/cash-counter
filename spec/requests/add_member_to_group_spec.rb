require 'rails_helper'

RSpec.describe 'add members request', type: :request do

  context 'with all valid parameters' do
    let(:admin) { admin = create(:user) }
    it 'adds the member to the group' do
      member_params = json_for member
      post_json add_member_path, params: member_params
      expect(response.status).to eq 200
      expect(response_value('success')).to eq true
    end
  end
end
