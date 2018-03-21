require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'validations' do
    describe 'start date and end date present' do
      it { is_expected.to validate_presence_of(:start_date) }
      it { is_expected.to validate_presence_of(:end_date) }
    end

    describe 'discount' do
      it { is_expected.to validate_presence_of(:discount) }
      it { is_expected.to validate_inclusion_of(:discount).in_array((1000..3000).to_a) }
    end

    describe 'internal message' do
      it { is_expected.to validate_presence_of(:internal_message) }
      it { is_expected.to validate_uniqueness_of(:internal_message) }
      it { is_expected.to validate_length_of(:internal_message).is_at_least(20) }
      it { is_expected.to validate_length_of(:internal_message).is_at_most(100) }
    end

    describe 'user message' do
      it { is_expected.to validate_presence_of(:user_message) }
      it { is_expected.to validate_length_of(:user_message).is_at_least(20) }
      it { is_expected.to validate_length_of(:user_message).is_at_most(100) }
    end

    describe 'code' do
      it { is_expected.to validate_presence_of(:code) }
      it { is_expected.to validate_uniqueness_of(:code) }
    end
  end

  describe 'relationships' do
    describe 'user' do
      it { is_expected.to have_many(:users) }
      it { is_expected.to have_many(:promotion_users) }
    end
  end

  describe 'user_can_use_promotion?' do
    let(:user) { create(:user) }
    let(:promo) { create(:promotion) }
    let(:assigned_promo) { create(:assigned_promotion) }

    it 'assigned is false' do
      expect(promo.user_can_use_promotion?(user)).to eq true
    end

    it 'assigned is true promo not for user' do
      expect(assigned_promo.user_can_use_promotion?(user)).to eq false
    end

    it 'assigned is true promo for user not redeemed' do
      assigned_promo.users << user
      expect(assigned_promo.user_can_use_promotion?(user)).to eq true
    end

    it 'assigned is true promo for user already redeemed' do
      assigned_promo.users << user
      po = assigned_promo.promotion_users.find_by(user: user)
      po.redeemed_at = Time.now
      po.save
      expect(assigned_promo.user_can_use_promotion?(user)).to eq false
    end
  end

  describe 'promotion_redeemed?' do
    let(:user) { create(:user) }
    let(:assigned_promo) { create(:assigned_promotion) }

    it 'has not been redeemed' do
      expect(assigned_promo.promotion_redeemed?(assigned_promo.users.first)).to eq false
    end

    it 'has been redeemed' do
      assigned_promo.users << user
      po = assigned_promo.promotion_users.find_by(user: user)
      po.redeemed_at = Time.now
      po.save
      expect(assigned_promo.promotion_redeemed?(user)).to eq true
    end
  end

  describe 'assigned?' do
    let(:promo) { create(:promotion) }
    let(:assigned_promo) { create(:assigned_promotion) }

    it 'assigned is default' do
      expect(promo.assigned?).to eq false
    end

    it 'assigned is true and promo has a user' do
      expect(assigned_promo.assigned?).to eq true
    end
  end

  describe 'after_create set_assigned_flag_if_users' do
    let(:user) { create(:user) }
    let(:promo) { build(:promotion) }

    context "when a user is assigned to a promo" do
      before {
        promo.users << user
        promo.save!
      }

      it {expect(promo.assigned).to eq true }
    end

    context "when a user is not assigned to a promo" do
      before {
        promo.save!
      }

      it {expect(promo.assigned).to eq false }
    end
  end
end
