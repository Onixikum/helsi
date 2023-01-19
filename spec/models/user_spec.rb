# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  context 'validations' do
    let!(:user) { create(:user) }

    context 'presence' do
      it { should validate_presence_of :phone }
      it { should validate_presence_of :encrypted_password }
      it { expect(user.profile).to validate_presence_of(:first_name) }
      it { expect(user.profile).to validate_presence_of(:last_name) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:phone).case_insensitive }
    end
  end
end
