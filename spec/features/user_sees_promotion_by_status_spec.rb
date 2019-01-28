require 'rails_helper'

feature 'User sees promotions by status' do
  scenario 'successfully' do
    user = create(:user, email: 'creator@promotions.com')
    login_as user, scope: :user
    promotion_not_expect = create(:promotion, status: 0,
                                              name: 'Promoção pendente')
    another_promotion_not_expect = create(:promotion, name: 'Promoção aprovada',
                                          creation_user: user,
                                                      status: 1)
    promotion_expect = create(:promotion, creation_user: user, status: 2,
                                          name: 'Promoção ativa')

    visit root_path

    select promotion_expect.status, from: 'Status'

    click_on 'Filtrar'

    expect(page).to have_content promotion_expect.discount
    expect(page).to have_content promotion_expect.name
    expect(page).to have_content promotion_expect.days

    expect(page).not_to have_content promotion_not_expect.name
    expect(page).not_to have_content another_promotion_not_expect.name
  end
end
