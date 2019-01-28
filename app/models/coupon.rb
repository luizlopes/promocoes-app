class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :promotion
  has_one :usage, class_name: 'CouponUsage'

  def self.generate_code(prefix)
    "#{prefix}#{SecureRandom.hex(5)}"
  end

  def available?
    usage.nil?
  end

  def unavailable?
    !available?
  end

  def status
    return 'unavailable' unless available?

    'available'
  end

  def unavailable!
    create_usage
  end
end
