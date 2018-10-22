# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::CustomerImage, type: :model do
  it { expect(build :customer_image).to be_valid }

  it 'requires variant' do
    expect(build :customer_image, variant: nil).to have_at_least(1).error_on :variant
  end

  it 'requires image' do
    expect(build :customer_image, image: nil).to have_at_least(1).error_on :image
  end

  it 'has product association via variant' do
    subject = create :customer_image
    expect(subject.product).to eql subject.variant.product
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

  describe 'approval methods' do
    subject { create :customer_image }

    describe '#approve' do
      it 'sets approved to true' do
        expect { subject.approve }.to change(subject, :approved).to true
      end
    end

    describe '#reject' do
      it 'sets approved to false' do
        expect { subject.reject }.to change(subject, :approved).to false
      end
    end
  end
end
