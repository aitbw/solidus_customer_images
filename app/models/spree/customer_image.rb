# frozen_string_literal: true

module Spree
  class CustomerImage < Spree::Base
    def self.ransackable_attributes(auth_object = nil)
      super + column_names
    end

    belongs_to :product, class_name: 'Spree::Product', inverse_of: :customer_images, foreign_key: :spree_product_id, touch: true
    belongs_to :user, class_name: Spree.user_class.name, inverse_of: :customer_images, foreign_key: :spree_user_id, touch: true
    has_one :image, class_name: SolidusCustomerImages::Config.image_class_name, as: :viewable, dependent: :destroy

    scope :approved, -> { where approved: true }
    scope :rejected, -> { where approved: false }
    scope :pending, -> { where approved: nil }

    accepts_nested_attributes_for :image

    validates :product, presence: true
    validates :image, presence: true
    validates :email, presence: true

    after_initialize :auto_assign_email
    after_initialize :auto_build_image

    def approve
      update approved: true
    end

    def reject
      update approved: false
    end

    private

    def auto_assign_email
      user && self.email ||= user.email
    end

    def auto_build_image
      image || build_image
    end
  end
end
