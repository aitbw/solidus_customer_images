# frozen_string_literal: true

Deface::Override.new(
  virtual_path: "spree/products/show",
  name: "customer_image_form_link",
  insert_after: '[data-hook="product_show"]',
  partial: 'spree/products/new_product_customer_image_link',
  disabled: !Rails.env.test?
)
