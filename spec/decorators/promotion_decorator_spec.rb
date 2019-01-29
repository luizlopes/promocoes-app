require 'rails_helper'

describe PromotionDecorator do
  describe "#approver_name" do
    it 'should return ----' do
      promotion = build(:promotion, status: :pending)
      decorator = PromotionDecorator.new(promotion)
      expect(decorator.approver_name).to eq '----'
    end

    it 'should return approver name if approver' do
      user = create(:user, name: 'joao')
      promotion = create(:promotion, status: :approved)
      create(:promotion_approval, user: user, promotion: promotion)
      decorator = PromotionDecorator.new(promotion)
      expect(decorator.approver_name).to eq 'Joao'
    end
  end
end
