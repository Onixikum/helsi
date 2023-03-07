# frozen_string_literal: true

RSpec.describe Doctors::HomeController, type: :controller do
  let(:doctor) { create(:doctor) }
  let(:user) { create(:user) }

  before { sign_in(doctor) }

  describe 'GET #show' do
    let(:open_appointments) { create_list(:appointment, 5, user: user, doctor: doctor) }
    let(:categories) do
      build_list(:category, 5) do |category|
        category.name = Faker::Lorem.sentence
        category.save!
      end
    end

    before do
      categories.map do |category|
        create(:specialization, doctor: doctor, category: category)
      end
      allow(controller).to receive(:current_doctor).and_return(doctor)
      allow(doctor).to receive(:appointments).and_return(Appointment)
      allow(Appointment).to receive(:opened).and_return(open_appointments)
      allow(doctor).to receive(:categories).and_return(categories)
    end

    subject { get :show }

    it 'assigns open appointments to @open_appointments' do
      subject
      expect(assigns(:open_appointments)).to eq(open_appointments)
    end

    it 'paginates open appointments by 5 per page' do
      expect(Appointment).to receive(:opened).and_return(open_appointments).ordered
      expect(open_appointments).to receive(:paginate).with(page: '2', per_page: 5).and_call_original.ordered
      get :show, params: { page: 2 }
    end

    it 'assigns categories to @categories' do
      subject
      expect(assigns(:categories)).to eq(categories)
    end

    it 'renders the show template' do
      subject
      expect(response).to render_template(:show)
    end
  end
end
