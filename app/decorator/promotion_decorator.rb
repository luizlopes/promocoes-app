class PromotionDecorator < Draper::Decorator
  delegate_all

  def approver_name
    return '----' if pending?
    approval.user.name.capitalize
  end

  def name
    "Promoção #{name}"
  end
end
