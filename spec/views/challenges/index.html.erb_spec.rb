require 'rails_helper'

RSpec.describe "challenges/index.html.erb", type: :view do

	before(:each) do
      @request.cookies[:telephone_number] = "447585601232"  # This line is crucial!
      @request.cookies[:code] = '1234'
    end
  it 'allows user to input mobile number' do
    visit root_path
    fill_in 'challenge_phone_number', with: '07585601232'
  end

  it 'allows user to input code' do
  end
end
