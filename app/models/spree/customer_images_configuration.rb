module Spree
  class CustomerImagesConfiguration < Preferences::Configuration
    preference :image_class_name, :string, default: 'Spree::Image'
  end
end
