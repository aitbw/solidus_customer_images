# frozen_string_literal: true

module Spree
  module Admin
    class CustomerImagesController < Spree::Admin::ResourceController
      helper CustomerImagesHelper

      def index
        params[:q] ||= {}
        @search = Spree::CustomerImage.ransack(params[:q])
        @customer_images = @search.result.order(created_at: :desc).includes(:product, :user, :variant, :image).page(params[:page])
      end

      def approve
        @customer_image.approve
        flash[:success] = Spree.t(:info_approve_customer_image)
        redirect_to admin_customer_images_path
      end

      def reject
        @customer_image.reject
        flash[:success] = Spree.t(:info_reject_customer_image)
        redirect_to admin_customer_images_path
      end
    end
  end
end
