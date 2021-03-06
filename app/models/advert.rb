# frozen_string_literal: true

class Advert < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :description, :title, :price, presence: true
  validates :description, length: { maximum: 10_000 }
  validates :title, length: { maximum: 255 }
  validates :price, numericality: { greater_than: 0 }
end
