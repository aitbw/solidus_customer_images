# frozen_string_literal: true

require 'spec_helper'

describe 'Create customer image' do
  let(:product) { create :product }

  let(:user_name) { 'John Doe III' }
  let(:email) { 'test@example.com' }
  let(:description) { FFaker::Lorem.paragraph }
  let(:image_path) { Rails.root.join '..', 'fixtures', 'image.gif' }

  before do
    visit spree.product_path(product)
    click_link 'add your picture'
  end

  it 'creates a new customer image' do
    fill_in 'User name', with: user_name
    fill_in 'Description', with: description
    fill_in 'Email', with: email
    click_button 'Submit picture'
    expect(page).to have_content "Image attachment can't be blank"

    attach_file('Filename', image_path)
    click_button 'Submit picture'
    expect(page).to have_content 'Customer image was successfully submitted'
    expect(page).to have_current_path spree.product_path(product)
  end
end
