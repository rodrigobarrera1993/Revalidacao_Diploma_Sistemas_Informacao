class Pilot < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :pilot_profile
  accepts_nested_attributes_for :pilot_profile, reject_if: :all_blank, allow_destroy: true
end
