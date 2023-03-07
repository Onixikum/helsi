# frozen_string_literal: true

RSpec.describe Users::DoctorsController, type: :controller do
  let(:user) { create(:user) }
  let(:doctor) { create(:doctor) }

  describe 'authorized user' do
    let(:category) { create(:category) }
    let(:specialization) { create(:specialization, doctor, category: category) }
    let(:appointment) { build(:appointment) }

    before do
      sign_in user
    end

    describe 'GET #show' do
      before { create_list(:appointment, 6, user: user, doctor: doctor) }

      subject { get :show, params: { id: user.id, doctor_id: doctor.id } }

      it 'assigns @doctor, @categories and @appointment' do
        subject
        expect(assigns(:doctor)).to eq(doctor)
        expect(assigns(:categories)).to eq(doctor.categories)
        expect(assigns(:appointment)).to be_a_new(Appointment)
      end

      it 'assigns @appointments with pagination' do
        subject
        expect(assigns(:appointments)).to eq(user.appointments.opened.paginate(page: 1, per_page: 5))
      end

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end
    end
  end

  describe 'unauthorized user' do
    describe 'GET #show' do
      subject { get :show, params: { id: user.id, doctor_id: doctor.id } }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
