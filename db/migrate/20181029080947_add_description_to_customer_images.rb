class AddDescriptionToCustomerImages < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_customer_images, :description, :text
  end
end
