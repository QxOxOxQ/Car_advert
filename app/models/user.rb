# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Blacklist

  validates :email, uniqueness: true, case_sensitive: false
  validates :email, :password, presence: true

  has_many :adverts
end
