require 'rails_helper'

RSpec.feature 'Create Group' do

  scenario 'unauthenticated user' do
    visit new_group_path
    expect_redirect_to new_user_session_path
  end
  
end
