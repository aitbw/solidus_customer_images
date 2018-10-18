# frozen_string_literal: true

Spree::Variant.class_eval do
  has_many :customer_images, dependent: :destroy
end
