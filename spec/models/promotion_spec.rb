require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it 'should be valid' do
    promotion = Promotion.create

    expect(promotion).not_to be_valid
    expect(promotion.errors[:discount]).to include('não pode ficar em branco')
    expect(promotion.errors[:name]).to include('não pode ficar em branco')
    expect(promotion.errors[:days]).to include('não pode ficar em branco')
    expect(promotion.errors[:prefix]).to include('não pode ficar em branco')
  end

  it 'should not be greater than 100%' do
    promotion = Promotion.create(discount: 101)

    expect(promotion).not_to be_valid
    expect(promotion.errors[:discount]).to include('deve ser entre 1 e 100%')
  end

  it 'should not be less than 1%' do
    promotion = Promotion.create(discount: 0)
    promotion2 = Promotion.create(discount: -1)

    expect(promotion).not_to be_valid
    expect(promotion2).not_to be_valid
    expect(promotion.errors[:discount]).to include('deve ser entre 1 e 100%')
    expect(promotion2.errors[:discount]).to include('deve ser entre 1 e 100%')
  end
end
