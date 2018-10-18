# frozen_string_literal: true

FactoryBot.define do
  factory :customer_image, class: 'Spree::CustomerImage' do
    association :image
    association :user
    association :product
  end
end
