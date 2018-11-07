# frozen_string_literal: true

require 'spec_helper'

module Spree
  module Admin
    RSpec.describe CustomerImagesController do
      context 'when logged in' do
        stub_authorization!

        let(:customer_image) { create :customer_image }

        describe 'GET index' do
          before { get :index }

          it { expect(response).to have_http_status :ok }

          context 'when customer reviews exist' do
            let!(:customer_images) { [create(:customer_image), create(:customer_image)] }

            it 'lists customer images' do
              expect(assigns[:customer_images]).to match_array customer_images
            end
          end
        end

        describe '#approve' do
          before { patch :approve, params: { id: customer_image.id } }

          it 'shows a message when approved' do
            expect(response).to redirect_to spree.admin_customer_images_path
            expect(flash[:success]).to eq I18n.t('spree.customer_images.info_approve')
          end
        end

        describe '#reject' do
          before { patch :reject, params: { id: customer_image.id } }

          it 'shows a message when rejected' do
            expect(response).to redirect_to spree.admin_customer_images_path
            expect(flash[:success]).to eq I18n.t('spree.customer_images.info_reject')
          end
        end
      end
    end
  end
end
