require 'rails_helper'

feature 'User' do
  scenario 'cancel cupom successfully' do
    creation_user = create(:user, email: 'creator@promotion.com')
    approval_user = create(:user, email: 'approver@promotion.com')
    promotion = create(:promotion, :approved,
                       creation_user: creation_user,
                       approval_user: approval_user)
    create(:coupon, promotion: promotion)

    login_as creation_user, scope: :user

    visit promotion_coupons_path(promotion)

    click_on 'Cancelar'

    expect(page).to have_content('Indisponível')
  end
end
