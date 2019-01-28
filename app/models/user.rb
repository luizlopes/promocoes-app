class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :promotions_created, class_name: 'Promotion',
                                foreign_key: 'creation_user_id',
                                inverse_of: false
  has_many :promotions_approved, class_name: 'Promotion',
                                 foreign_key: 'approval_user_id',
                                 inverse_of: false

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :coupons
end
