# frozen_string_literal: true

require 'spec_helper'

describe 'Admin customer images list page' do
  stub_authorization!

  let(:user_email) { 'foobar@example.com' }
  let(:product_name) { 'Serious Spark Plugs' }

  let(:user) { create :user, email: user_email }
  let(:product) { create :product, name: product_name }

  let!(:customer_image) { create :customer_image, product: product, user: user, approved: nil }

  it 'shows customer images information' do
    visit spree.admin_customer_images_path
    expect(page).to have_content user_email
    expect(page).to have_content product_name
    expect(page).to have_selector "img[src='#{customer_image.image.attachment.url(:mini)}']"
  end

  it 'can destroy customer images', js: true do
    visit spree.admin_customer_images_path
    expect(page).to have_content product_name
    accept_alert do
      find('.fa-trash').click
    end
    expect(page).not_to have_content product_name
  end

  it 'can approve customer images', js: true do
    expect(page).not_to have_selector 'i.approved'
    visit spree.admin_customer_images_path
    find('a.approve').click
    expect(page).to have_selector 'i.approved'
  end

  it 'can reject customer images', js: true do
    expect(page).not_to have_selector 'i.rejected'
    visit spree.admin_customer_images_path
    find('a.reject').click
    expect(page).to have_selector 'i.rejected'
  end
end
