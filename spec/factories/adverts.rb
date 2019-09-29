# frozen_string_literal: true

FactoryBot.define do
  factory :advert do
    title { 'MyString' }
    description { 'MyText' }
    price { 1.5 }
  end
end
