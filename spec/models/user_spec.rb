require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create valid user' do
    user = create(:user)

    expect(user).to be_valid
  end

  it 'create user shouldn\'t be valid' do
    user = User.create

    expect(user).not_to be_valid
    expect(user.errors[:name]).to include 'não pode ficar em branco'
    expect(user.errors[:email]).to include 'não pode ficar em branco'
  end

  it 'email should be unique' do
    create(:user, name: 'eu', email: 'teste@teste')
    another_user = User.create(name: 'eu2', email: 'teste@teste')

    expect(another_user).not_to be_valid
    expect(another_user.errors[:email]).to include 'já está em uso'
  end
end
