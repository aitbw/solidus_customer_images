# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::CustomerImage, type: :model do
  it { expect(build :customer_image).to be_valid }

  it 'requires product' do
    expect(build :customer_image, product: nil).to have_at_least(1).error_on :product
  end

  it 'requires image' do
    expect(build :customer_image, image: nil).to have_at_least(1).error_on :image
  end

  describe '::approved' do
    before { create :customer_image, approved: false }

    it 'selects approved customer images' do
      found = create :customer_image, approved: true
      expect(described_class.approved).to eq [found]
    end
  end

  describe '::rejected' do
    before { create :customer_image, approved: true }

    it 'selects rejected customer images' do
      found = create :customer_image, approved: false
      expect(described_class.rejected).to eq [found]
    end
  end

  describe '::pending' do
    before { create :customer_image, approved: true }

    it 'selects pending customer images' do
      found = create :customer_image, approved: nil
      expect(described_class.pending).to eq [found]
    end
  end
end
