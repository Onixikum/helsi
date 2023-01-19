# frozen_string_literal: true

RSpec.describe Category, type: :model do
  describe 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:category)).to be_valid
    end
  end

  describe 'validations' do
    before { create(:category) }

    describe 'associations' do
      it { should have_many(:specializations) }
      it { should have_many(:doctors) }
    end

    describe 'presence' do
      it { should validate_presence_of :name }
    end

    describe 'uniqueness' do
      it { should validate_uniqueness_of(:name).case_insensitive }
    end
  end
end
