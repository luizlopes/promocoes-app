class PromotionDecorator < Draper::Decorator
  delegate_all

  def approver_name
    approval.user.name.capitalize
  end

  def name
    "Promoção #{object.name}"
  end
end
