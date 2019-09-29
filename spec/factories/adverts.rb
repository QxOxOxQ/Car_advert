# frozen_string_literal: true

FactoryBot.define do
  factory :advert do
    title { 'MyString' }
    description { 'MyText' }
    price { 1.5 }
    user
    image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg'), 'image/jpg') }
  end
end
