# frozen_string_literal: true

Spree::Product.class_eval do
  has_many :customer_images, dependent: :destroy, foreign_key: 'spree_product_id'
end
