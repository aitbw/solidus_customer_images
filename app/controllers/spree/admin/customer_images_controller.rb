# frozen_string_literal: true

module Spree
  module Admin
    class CustomerImagesController < Spree::Admin::ResourceController
      helper CustomerImagesHelper

      def index
        params[:q] ||= {}
        @search = Spree::CustomerImage.ransack(params[:q])
        @customer_images = @search.result.order(created_at: :desc).includes(:product, :user, :image).page(params[:page])
      end

      def approve
        @customer_image.approve
        flash[:success] = I18n.t('spree.customer_images.info_approve')
        redirect_to admin_customer_images_path
      end

      def reject
        @customer_image.reject
        flash[:success] = I18n.t('spree.customer_images.info_reject')
        redirect_to admin_customer_images_path
      end
    end
  end
end
