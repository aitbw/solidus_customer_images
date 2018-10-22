class CreateSpreeCustomerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_customer_images do |t|
      t.boolean :approved, default: nil
      t.references :variant, index: true
      t.references :user, index: true
      t.timestamps
    end

    # Adding foreign keys later, see https://stackoverflow.com/questions/44701680
    add_reference :spree_customer_images, :spree_variants
    add_reference :spree_customer_images, Spree.user_class.table_name
  end
end
