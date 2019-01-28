require 'rails_helper'

describe PromotionPresenter do
  describe '#status' do
    it 'should return pending status' do
      promotion = build(:promotion, status: :pending)
      presenter = PromotionPresenter.new(promotion, nil)
      expect(presenter.status).to eq('<span class="ls-tag-warning">Pendente</span>')
    end

    it 'should render approved status' do
      promotion = build(:promotion, status: :approved)

      presenter = PromotionPresenter.new(promotion, nil)
      expect(presenter.status).to eq('<span class="ls-tag-info">Aprovada</span>')
    end

    it 'should render activated status' do
      promotion = build(:promotion, status: :activated)

      presenter = PromotionPresenter.new(promotion, nil)
      expect(presenter.status).to eq('<span class="ls-tag-success">Ativado</span>')
    end

    it 'should render expired status' do
      promotion = build(:promotion, status: :expired)

      presenter = PromotionPresenter.new(promotion, nil)
      expect(presenter.status).to eq('<span class="ls-tag-alert">Expirada</span>')
    end
  end
end
