require 'rails_helper'

feature 'User' do
  scenario 'sign up successfully' do
    user = build(:user)

    visit new_user_registration_path

    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Registrar'

    expect(current_path).to eq root_path
  end

  scenario 'sign in successfully' do
    user = create(:user, email: 'user@promotion.com')

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    within('div.ls-topbar') do
      expect(page).to have_content(user.name)
    end
  end
end
