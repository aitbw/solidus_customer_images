Spree::Backend::Config.configure do |config|
  config.menu_items.detect { |menu_item|
    menu_item.label == :products
  }.sections << :customer_images
end

Deface::Override.new(
  virtual_path: "spree/admin/shared/_product_sub_menu",
  name: "customer_images_admin_tab",
  insert_bottom: "[data-hook='admin_product_sub_tabs']",
  text: "<%= tab(:customer_images, label: 'customer_images_management') %>"
)
