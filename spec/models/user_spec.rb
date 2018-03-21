require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'username' do
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_uniqueness_of(:username) }
    end
  end

  describe 'relationships' do
    describe 'promotion' do
      it { is_expected.to have_many(:promotions) }
      it { is_expected.to have_many(:promotion_users) }
    end
  end
end
