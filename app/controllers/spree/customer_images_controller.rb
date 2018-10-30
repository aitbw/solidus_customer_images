module Spree
  class CustomerImagesController < Spree::StoreController
    helper Spree::BaseHelper

    before_action :load_product

    def new
      @customer_image = Spree::CustomerImage.new(base_review_params)
    end

    def create
      @customer_image = Spree::CustomerImage.new(review_params)
      if @customer_image.save
        flash[:success] = Spree.t('customer_image_successfully_submitted')
        redirect_to spree.product_path(@product)
      else
        render :new
      end
    end

    private

    def load_product
      @product = Spree::Product.friendly.find(params[:product_id])
    end

    def base_review_params
      { user: try_spree_current_user, product: @product }
    end

    def review_params
      permitted = [:user_name, :email, :description, image_attributes: [:attachment]]
      params.require(:customer_image).permit(permitted).merge(base_review_params)
    end
  end
end
