# frozen_string_literal: true

Spree.user_class.class_eval do
  has_many :customer_images, dependent: :nullify
end
