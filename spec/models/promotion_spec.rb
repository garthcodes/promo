require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_presence_of(:user_message) }
  end

  describe 'internal message' do
    it { is_expected.to validate_presence_of(:internal_message) }
    it { is_expected.to validate_uniqueness_of(:internal_message) }
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
end
