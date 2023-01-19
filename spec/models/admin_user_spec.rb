# frozen_string_literal: true

RSpec.describe AdminUser, type: :model do
  describe 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:admin_user)).to be_valid
    end
  end

  describe 'validations' do
    before { create(:admin_user) }

    describe 'presence' do
      it { should validate_presence_of :phone }
      it { should validate_presence_of :encrypted_password }
    end

    describe 'uniqueness' do
      it { should validate_uniqueness_of(:phone).case_insensitive }
    end
  end
end
