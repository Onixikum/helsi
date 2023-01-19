# frozen_string_literal: true

RSpec.describe Appointment, type: :model do
  describe 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:category)).to be_valid
    end
  end

  describe 'validations' do
    let(:doctor) { create(:doctor) }
    let(:user) { create(:user) }
    let!(:appointment) { create(:appointment, doctor: doctor, user: user) }

    describe 'associations' do
      it { should belong_to(:doctor).without_validating_presence }
      it { should belong_to(:user).without_validating_presence }
    end

    describe 'presence' do
      it { should validate_presence_of :doctor_id }
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :appointment_date }
      it { should validate_presence_of :symptoms }
    end
  end
end
