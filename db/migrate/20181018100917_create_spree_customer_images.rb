class CreateSpreeCustomerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_customer_images do |t|
      t.boolean :approved, default: nil
      t.references :spree_product, index: true
      t.references :spree_user, index: true
      t.timestamps
    end
  end
end
