require 'rails_helper'

RSpec.describe Promotion, type: :model do
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

  describe 'user' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:promotion_users) }
  end

  describe 'user_can_use_promotion?' do
    it 'assigned is false' do
      user = create(:user)
      promo = create(:promotion)
      expect(promo.user_can_use_promotion?(user)).to eq true
    end

    it 'assigned is true promo not for user' do
      user = create(:user)
      promo = create(:assigned_promotion)
      expect(promo.user_can_use_promotion?(user)).to eq false
    end

    it 'assigned is true promo for user' do
      user = create(:user)
      promo = create(:assigned_promotion)
      promo.users << user
      expect(promo.user_can_use_promotion?(user)).to eq true
    end
  end

  describe 'assigned?' do
    it 'assigned is default' do
      promo = create(:promotion)
      expect(promo.assigned?).to eq false
    end

    it 'assigned is true and promo has a user' do
      user = create(:user)
      promo = create(:assigned_promotion)
      promo.users << user
      expect(promo.assigned?).to eq true
    end
  end
end
