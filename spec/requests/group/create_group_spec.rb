require 'rails_helper'

RSpec.describe 'Create Group', type: :request do

  context 'with all valid parameters' do
    let(:admin) { admin = create(:user) }
    it 'creats new group' do
        group_params = build_json_for :group, {admin_id: admin.id}
        post_json groups_path, params: group_params
        expect(response.status).to eq 200
        expect(response_value('success')).to eq true
    end
  end

  context 'with incomplete parameters' do
    it 'doesnot create new group without admin id' do
        group_params = build_json_for :group
        post_json groups_path, params: group_params
        expect(response.status).to eq 400
        expect(response_value('success')).to eq false
    end
  end

end
