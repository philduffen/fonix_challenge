require 'rails_helper'

RSpec.describe "challenges/index.html.erb", type: :view do
  it 'allows user to input mobile number' do
    visit root_path
    fill_in 'challenge_phone_number', with: '074545601232'
  end
end
