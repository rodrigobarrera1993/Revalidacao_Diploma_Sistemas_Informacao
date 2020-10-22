class Operator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :operator_profile
  accepts_nested_attributes_for :operator_profile, reject_if: :all_blank, allow_destroy: true
end
