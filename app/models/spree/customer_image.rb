# frozen_string_literal: true

module Spree
  class CustomerImage < Spree::Base
    belongs_to :variant, class_name: 'Spree::Variant', inverse_of: :customer_images, foreign_key: :variant_id, touch: true
    belongs_to :user, class_name: Spree.user_class.name, inverse_of: :customer_images, foreign_key: :user_id, touch: true
    has_one :image, class_name: 'Spree::Image', as: :viewable, dependent: :destroy
    has_one :product, through: :variant

    scope :approved, -> { where approved: true }
    scope :rejected, -> { where approved: false }
    scope :pending, -> { where approved: nil }

    validates :variant, presence: true
    validates :image, presence: true
  end
end
