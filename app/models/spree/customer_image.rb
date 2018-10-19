# frozen_string_literal: true

module Spree
  class CustomerImage < Spree::Base
    def self.ransackable_attributes(auth_object = nil)
      super + column_names
    end

    belongs_to :variant, class_name: 'Spree::Variant', inverse_of: :customer_images, foreign_key: :variant_id, touch: true
    belongs_to :user, class_name: Spree.user_class.name, inverse_of: :customer_images, foreign_key: :user_id, touch: true
    has_one :image, class_name: 'Spree::Image', as: :viewable, dependent: :destroy
    has_one :product, through: :variant

    scope :approved, -> { where approved: true }
    scope :rejected, -> { where approved: false }
    scope :pending, -> { where approved: nil }

    validates :variant, presence: true
    validates :image, presence: true

    def approve
      update approved: true
    end

    def reject
      update approved: false
    end
  end
end