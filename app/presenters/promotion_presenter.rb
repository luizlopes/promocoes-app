class PromotionPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  delegate :content_tag, :link_to, to: :helpers
  attr_reader :current_user

  def initialize(promotion, current_user)
    @current_user = current_user
    super(promotion)
  end

  def status
    if pending?
      content_tag(:span, class: 'ls-tag-warning') do
        "Pendente"
      end
    elsif approved?
      content_tag(:span, class: 'ls-tag-info') do
        "Aprovada"
      end
    elsif activated?
      content_tag(:span, class: 'ls-tag-success') do
        "Ativado"
      end
    else
      content_tag(:span, class: 'ls-tag-alert') do
        "Expirada"
      end
    end
  end

  def approval_link
    return '' unless authorizer.can_approve?

    content_tag(:div, class: 'ls-actions-btn') do
      link_to 'Aprovar Promoção', approve_promotion_path(id: id), method: :put, class: 'ls-btn-primary ls-btn-lg'
    end
  end

  private
  def helpers
    ApplicationController.helpers
  end

  def authorizer
    @authorizer ||= PromotionAuthorizer.new(self, current_user)
  end
end
