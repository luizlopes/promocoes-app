require 'rails_helper'

feature 'User' do
  scenario 'creates a promotion successfully' do
    user = create(:user, email: 'user@promotion.com')
    product = create(:product, product_key: 'LIVR01')
    promotion = build(:promotion, creation_user: user, product: product)
    login_as user, scope: :user

    visit new_promotion_path

    fill_in 'Descrição', with: promotion.description
    fill_in 'Desconto', with: promotion.discount
    fill_in 'Nome', with: promotion.name
    fill_in 'Data de início', with: promotion.start_at
    fill_in 'Duração', with: promotion.days
    select product.name, from: 'Produtos'
    fill_in 'Limite de cupons para emissão', with: 100
    click_on 'Criar Promoção'

    expect(page).to have_content promotion.description
    expect(page).to have_content promotion.discount
    expect(page).to have_content promotion.name.capitalize
    expect(page).to have_content I18n.l(promotion.start_at, format: :long)
    expect(page).to have_content promotion.days
    expect(page).to have_content promotion.product.product_key
    expect(page).to have_content promotion.product.name
    expect(page).to have_content promotion.coupon_limit
    expect(page).to have_content promotion.coupons.count
  end

  scenario 'creates a promotion failure' do
    user = create(:user, email: 'user@promotion.com')
    create(:product, product_key: 'LIVR01')
    login_as user, scope: :user
    visit new_promotion_path

    fill_in 'Descrição', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Nome', with: ''
    fill_in 'Duração', with: ''
    fill_in 'Limite de cupons para emissão', with: ''

    click_on 'Criar Promoção'

    expect(page).to have_content('Preencha os campos corretamente.')
  end
end
