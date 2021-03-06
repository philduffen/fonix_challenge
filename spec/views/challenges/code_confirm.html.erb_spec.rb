require 'rails_helper'

RSpec.describe "challenges/code_confirm.html.erb", type: :view do
  before(:each) do
    @request.cookies[:phone_number] = "447585601232"  # This line is crucial!
    @request.cookies[:code] = cookies[:code]
  end

  it 'allows user to input code' do
    visit root_path
    fill_in 'challenge_phone_number', with: '07585601232'
    click_on 'Confirm!'
    expect(current_path).to eq challenges_code_confirm_path
    fill_in 'challenge_code', with: '1234'
  end

  it 'check happy path' do
    visit root_path
    fill_in 'challenge_phone_number', with: '07585601232'
    click_on 'Confirm!'
    expect(current_path).to eq challenges_code_confirm_path
    fill_in 'challenge_code', with: '1234'
    click_on 'Confirm!'
    expect(page).to have_content("Congratulations")
  end

  it 'check sad path' do
    visit root_path
    fill_in 'challenge_phone_number', with: '07585601232'
    click_on 'Confirm!'
    expect(current_path).to eq challenges_code_confirm_path
    fill_in 'challenge_code', with: '4321'
    click_on 'Confirm!'
    expect(current_path).to eq root_path
  end
end
