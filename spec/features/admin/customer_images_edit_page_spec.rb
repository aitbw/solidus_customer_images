# frozen_string_literal: true

require 'spec_helper'

describe 'Admin customer image edit page' do
  stub_authorization!

  let(:new_name) { 'John Doe III' }
  let(:new_description) { FFaker::Lorem.paragraph }
  let!(:customer_image) { create :customer_image }

  it 'updates customer image attributes' do
    visit spree.edit_admin_customer_image_path(customer_image)
    fill_in 'User name', with: new_name
    fill_in 'Description', with: new_description
    click_button 'Update'
    expect(page).to have_content 'Customer image has been successfully updated'
    expect(page).to have_content new_name
    expect(page).to have_content new_description[0..20]
  end
end
