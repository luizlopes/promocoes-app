module PromotionHelper
  def promotion_status(promotion)

    if promotion.pending?
      content_tag(:span, class: 'ls-tag-warning') do
        "Pendente"
      end
    elsif promotion.approved?
      content_tag(:span, class: 'ls-tag-info') do
        "Aprovada"
      end
    elsif promotion.activated?
      content_tag(:span, class: 'ls-tag-success') do
        "Ativado"
      end
    else
      content_tag(:span, class: 'ls-tag-alert') do
        "Expirada"
      end
    end
  end
end
