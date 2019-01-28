require 'rails_helper'

feature 'Admin register product' do
  scenario 'successfully' do
    user = create(:user, :admin)
    product = build(:product, name: 'Livro', description: 'Livro muito legal',
                              product_key: 'LIVR0')

    login_as user, scope: :user
    visit root_path
    click_on 'Novo Produto'
    fill_in 'Nome', with: product.name
    fill_in 'Descrição', with: product.description
    fill_in 'Chave do produto', with: product.product_key
    click_on 'Criar Produto'

    expect(page).to have_content('Livro')
    expect(page).to have_content('Livro muito legal')
    expect(page).to have_content('LIVR0')
  end

  scenario 'and don\'t view button unless admin' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path

    expect(page).not_to have_button('Novo Produto')
  end
end
