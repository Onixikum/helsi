# frozen_string_literal: true

RSpec.describe Specialization, type: :model do
  describe 'validations' do
    let(:doctor) { create(:doctor) }
    let(:category) { create(:category) }
    let!(:specialization) { create(:specialization, doctor: doctor, category: category) }

    describe 'associations' do
      it { should belong_to(:doctor).without_validating_presence }
      it { should belong_to(:category).without_validating_presence }
    end

    describe 'presence' do
      it { should validate_presence_of :doctor_id }
      it { should validate_presence_of :category_id }
    end

    describe 'uniqueness' do
      it { should validate_uniqueness_of(:doctor_id).scoped_to(:category_id) }
    end
  end
end
