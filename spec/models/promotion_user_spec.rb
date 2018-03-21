require 'rails_helper'

RSpec.describe PromotionUser, type: :model do
  describe 'presence' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:promotion) }
  end
end