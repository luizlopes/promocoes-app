require 'rails_helper'

feature 'User approves promotion' do
  scenario 'successfully' do
    promotion = create(:promotion, name: 'Bla', status: :pending)
    user = create(:user)
    approval_button = 'Aprovar Promoção'

    login_as user, scope: :user
    visit promotion_path(promotion)

    click_on approval_button

    expect(page).to have_button 'Emitir Cupons'
    expect(page).not_to have_content approval_button
    expect(page).to have_content 'Aprovada'
  end

  scenario 'only if they are not the promo`s creator' do
    user = create(:user)
    promotion = create(:promotion, creation_user: user)

    login_as user, scope: :user
    visit promotion_path(promotion)

    expect(page).to have_content 'Pendente'
    expect(page).not_to have_link 'Aprovar Promoção'
    expect(page).not_to have_button 'Emitir Cupons'
  end
end
