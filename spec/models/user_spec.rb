# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'validations' do
    let!(:user) { create(:user) }

    describe 'associations' do
      it { should have_one(:profile) }
      it { should have_many(:appointments) }
    end

    describe 'presence' do
      it { should validate_presence_of :phone }
      it { should validate_presence_of :encrypted_password }
      it { expect(user.profile).to validate_presence_of(:first_name) }
      it { expect(user.profile).to validate_presence_of(:last_name) }
    end

    describe 'uniqueness' do
      it { should validate_uniqueness_of(:phone).case_insensitive }
    end
  end
end
