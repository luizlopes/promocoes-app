class Promotion < ApplicationRecord
  enum status: %i[pending approved activated expired]

  belongs_to :creation_user, class_name: 'User'
  belongs_to :product
  has_one :approval, class_name: 'PromotionApproval'
  has_many :coupons
  validates :discount, numericality: { less_than: 101, greater_than: 0,
                                       message: 'deve ser entre 1 e 100%' }
  validates :days, numericality: { greater_than: 0 }
  validates :description,
            :discount,
            :name,
            :start_at,
            :days,
            :prefix,
            :coupon_limit,
            presence: true

  scope :user_promotion, ->(user) { where(creation_user: user) }
  scope :pending_promotions, lambda { |user|
    where(status: :pending).where.not(creation_user: user)
  }
  scope :other_promotions, lambda { |user|
    where.not(status: :pending, creation_user: user)
  }

  def self.find_promotion_by_user(name)
    Promotion.where(creation_user: User.where('name LIKE ?', "%#{name}%"))
  end

  def self.find_promotion_by_status(status)
    Promotion.where(status: status)
  end

  def promotion_expired?
    if activated?
      if (activated_at + days.days) < Time.zone.now
        expired!
      end
    end
    expired?
  end

  def active!
    update(activated_at: Time.zone.now, status: :activated)
  end
end
