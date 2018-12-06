module Spree
  class CustomerImagesController < Spree::StoreController
    helper Spree::BaseHelper

    before_action :load_product

    def new
      @title = I18n.t('spree.customer_images.new_image_page_title', name: @product.name)
      @customer_image = Spree::CustomerImage.new(base_customer_image_params)
    end

    def create
      @customer_image = Spree::CustomerImage.new(customer_image_params)
      if @customer_image.save
        flash[:success] = I18n.t('spree.customer_images.successfully_submitted')
        redirect_to spree.product_path(@product)
      else
        render :new
      end
    end

    private

    def load_product
      @product = Spree::Product.friendly.find(params[:product_id])
    end

    def base_customer_image_params
      { user: try_spree_current_user, product: @product }
    end

    def customer_image_params
      permitted = [:user_name, :email, :description, image_attributes: [:attachment]]
      params.require(:customer_image).permit(permitted).merge(base_customer_image_params)
    end
  end
end
