# frozen_string_literal: true

require 'spec_helper'

module Spree
  describe CustomerImagesController, type: :controller do
    let(:user) { create(:user) }
    let(:product) { create(:product) }
    let(:image_path) { Rails.root.join '..', 'fixtures', 'image.gif' }
    let(:customer_image_params) do
      {
        product_id: product.slug,
        customer_image: {
          email: 'foo@bar.com',
          image_attributes: {
            attachment: Rack::Test::UploadedFile.new(image_path, 'image/gif')
          }
        }
      }
    end

    describe '#new' do
      context 'for a product that does not exist' do
        it 'responds with a 404' do
          expect {
            get :new, params: { product_id: 'fake' }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      it 'render the new template' do
        get :new, params: { product_id: product.slug }
        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
      end
    end

    describe '#create' do
      context 'for a product that does not exist' do
        it 'responds with a 404' do
          expect {
            post :create, params: { product_id: 'not_real' }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      it 'creates a new customer image' do
        expect {
          post :create, params: customer_image_params
        }.to change(Spree::CustomerImage, :count).by(1)
      end

      it 'flashes the notice' do
        post :create, params: customer_image_params
        expect(flash[:success]).to eq Spree.t(:customer_image_successfully_submitted)
      end

      it 'redirects to product page' do
        post :create, params: customer_image_params
        expect(response).to redirect_to spree.product_path(product)
      end

      context 'with invalid params' do
        before { Spree::CustomerImage.any_instance.stub(:save).and_return(false) }

        it 'renders new when customer image cannot be saved' do
          post :create, params: customer_image_params
          expect(response).to render_template :new
        end

        it 'does not create a customer image' do
          expect do
            post :create, params: customer_image_params.merge(email: nil)
          end.not_to change Spree::CustomerImage, :count
        end
      end
    end
  end
end
