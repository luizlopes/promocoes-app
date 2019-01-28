require 'rails_helper'

feature 'Coupons become unavailable when promotion expires' do
  scenario 'successfully' do
    travel_to 21.days.ago do
      creation_user = create(:user, email: 'creator@promotion.com')
      user = create(:user, email: 'emissor@promotion.com')
      @promotion = create(:promotion, :approved, creation_user: creation_user,
                                                 days: 20, status: :approved,
                                                 approval_user: user)
      login_as user, scope: :user
      visit promotion_path(@promotion)
      click_on 'Ativar'
      fill_in 'Quantidade', with: 5
      click_on 'Emitir Cupons'
    end

    current_user = create(:user)
    login_as current_user, scope: :user
    visit promotion_coupons_path(@promotion)
    expect(page).to have_content @promotion.prefix, count: 5
    expect(page).to have_content 'Indisponível', count: 5
  end

  scenario 'Coupons is available when promotion is not expired' do
    travel_to 19.days.ago do
      creation_user = create(:user, email: 'creator@promotion.com')
      approval_user= create(:user, email: 'approval@promotion.com')
      @promotion = create(:promotion, :approved, creation_user: creation_user,
                                                 days: 20, status: :approved,
                                                 approval_user: approval_user)
      user = create(:user)
      login_as user, scope: :user
      visit promotion_path(@promotion)
      click_on 'Ativar'
      fill_in 'Quantidade', with: 5
      click_on 'Emitir Cupons'
    end

    current_user = create(:user)
    login_as current_user, scope: :user
    visit promotion_coupons_path(@promotion)
    expect(page).to have_content @promotion.prefix, count: 5
    expect(page).to have_content 'Disponível', count: 5
  end
end
