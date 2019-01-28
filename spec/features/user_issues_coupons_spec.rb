require 'rails_helper'

feature 'User issues coupons' do
  before do
    creation_user = create(:user)
    approval_user = create(:user)
    @promotion = create(:promotion, :approved, creation_user: creation_user,
                       approval_user: approval_user,
                       coupon_limit: 50,
                       status: :approved)
    login_as creation_user, scope: :user
  end

  scenario 'successfully' do
    visit promotion_path(@promotion)

    fill_in 'Quantidade', with: '10'
    click_on 'Emitir Cupons'

    expect(page).to have_content 'Cupons Gerados:'
    expect(page).to have_content @promotion.prefix, count: 10
    expect(page).to have_content 'Disponível', count: 10
  end

  scenario 'again for the same promotion' do
    2.times do
      visit promotion_path(@promotion)

      fill_in 'Quantidade', with: '25'
      click_on 'Emitir Cupons'
    end

    expect(page).to have_content 'Cupons Gerados:'
    expect(page).to have_content @promotion.prefix, count: 50
    expect(page).to have_content 'Disponível', count: 50
  end

  scenario 'and dont surpass the coupons limit defined' do
    msg_expect = 'Numero de cupons ultrapassa limite de emissao estabelecido'

    visit promotion_path(@promotion)

    fill_in 'Quantidade', with: '51'
    click_on 'Emitir Cupons'
    expect(page).to have_content msg_expect
  end
end
