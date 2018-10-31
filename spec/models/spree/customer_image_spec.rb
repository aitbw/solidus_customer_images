# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::CustomerImage, type: :model do
  it { expect(build :customer_image).to be_valid }

  it 'requires product' do
    expect(build :customer_image, product: nil).to have_at_least(1).error_on :product
  end

  it 'requires email' do
    expect(build :customer_image, email: nil).to have_at_least(1).error_on :email
  end

  it 'automatically builds image when missing' do
    expect(described_class.new.image).to be_present
  end

  context 'when initializing a record' do
    let(:user) { Spree.user_class.new(email: 'foo@bar.com') }
    let(:email) { 'test@example.com' }

    context 'when the record has no email' do
      context 'when the record has no user too' do
        it { expect(subject.email).to be_nil }
      end

      context 'when the record has user' do
        subject { described_class.new user: user }

        it { expect(subject.email).to eql user.email }
      end
    end

    context 'when the record has email' do
      context 'when the email is different from the one of the user' do
        subject { described_class.new email: email, user: user }

        it { expect(subject.email).to eql email }
      end

      context 'whe  the email is same as the one of the user' do
        subject { described_class.new email: user.email, user: user }

        it { expect(subject.email).to eql user.email }
      end
    end
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
