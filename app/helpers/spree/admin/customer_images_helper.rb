# frozen_string_literal: true

module Spree
  module Admin
    module CustomerImagesHelper
      def customer_image_icon(customer_image)
        css_class = begin
          case customer_image.approved
          when true then 'approved fa-ok'
          when false then 'rejected fa-ban'
          end
        end
        tag.i class: "fa #{css_class}"
      end
    end
  end
end
