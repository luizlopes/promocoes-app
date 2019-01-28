require 'rails_helper'

feature 'View' do
  scenario 'home with nav' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user

    visit root_path

    expect(page).to have_link(href: new_promotion_path)
    expect(page).to have_link(href: promotions_path)
    expect(page).to have_link(href: destroy_user_session_path)
  end

  scenario 'home to new promotion' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user

    visit root_path

    click_on 'Nova Promoção'

    expect(current_path).to eq new_promotion_path
  end

  scenario 'home to index promotion' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user

    visit root_path

    click_on 'Home'

    expect(current_path).to eq promotions_path
  end

  scenario 'index to show promotion' do
    user = create(:user, email: 'user@promotion.com')
    login_as user, scope: :user
    promotion = create(:promotion, creation_user: user, name: 'Promoção legal',
                      description: 'Muito legal')
    visit root_path

    click_on 'Home'
    click_on promotion.name

    expect(page).to have_content promotion.description
    expect(page).to have_content promotion.discount
    expect(page).to have_content promotion.name.capitalize
    expect(page).to have_content promotion.days
    expect(page).to have_content promotion.prefix
    expect(page).to have_content promotion.product_id
    expect(page).to have_content promotion.coupons.count
  end
end
