require 'rails_helper'

feature 'User' do
  scenario 'sees promotions successfully' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user
    promotions_list = create_list(:promotion, 5, creation_user: user)

    visit root_path
    promotions_list.each do |promotion|
      expect(page).to have_content promotion.discount
      expect(page).to have_content promotion.name
      expect(page).to have_content promotion.days
    end
  end

  scenario 'search promotions successfully' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user
    another_user = create(:user)
    promotions_expect = create_list(:promotion, 5, creation_user: user)
    promotions_not_expect = create_list(:promotion, 5,
                                        creation_user: another_user)

    visit root_path

    fill_in 'Search', with: user.name
    click_on 'Pesquisar'

    promotions_expect.each do |promotion|
      expect(page).to have_content promotion.discount
      expect(page).to have_content promotion.name
      expect(page).to have_content promotion.days
    end

    promotions_not_expect.each do |promotion|
      expect(page).not_to have_content promotion.name
    end
  end
end
