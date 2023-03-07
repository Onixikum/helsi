# frozen_string_literal: true

RSpec.describe Doctors::UsersController, type: :controller do
  describe 'authorized user' do
    let(:doctor) { create(:doctor) }
    let(:user) { create(:user) }

    before { sign_in doctor }

    describe 'GET #index' do
      subject { get :index }

      context 'when the doctor has appointments with open status' do
        let!(:open_appointments) { create_list(:appointment, 3, doctor: doctor, user: user) }

        before { create(:appointment, :closing, doctor: doctor, user: user) }

        it 'assigns the open appointments to @patients' do
          subject
          expect(assigns(:patients)).to match_array(open_appointments.map(&:user).uniq)
        end

        it 'renders the index template' do
          expect(subject).to render_template(:index)
        end
      end

      context 'when the doctor has no appointments with open status' do
        before { create_list(:appointment, 3, :closing, doctor: doctor, user: user) }

        it 'assigns an empty array to @patients' do
          subject
          expect(assigns(:patients)).to eq([])
        end

        it 'renders the index template' do
          expect(subject).to render_template(:index)
        end
      end
    end

    describe 'GET #show' do
      subject { get :show, params: { id: user.id } }

      context 'when the user has open appointments' do
        let!(:open_appointments) { create_list(:appointment, 3, doctor: doctor, user: user) }

        before { create(:appointment, :closing, doctor: doctor, user: user) }

        it 'assigns the open appointments to @open_appointments' do
          subject
          expect(assigns(:open_appointments)).to match_array(open_appointments)
        end

        it 'renders the show template' do
          expect(subject).to render_template(:show)
        end
      end

      context 'when the user has no open appointments' do
        before { create_list(:appointment, 3, :closing, doctor: doctor, user: user) }

        it 'assigns an empty array to @open_appointments' do
          subject
          expect(assigns(:open_appointments)).to eq([])
        end

        it 'renders the show template' do
          expect(subject).to render_template(:show)
        end
      end
    end

    describe 'GET #history' do
      let!(:closed_appointments) { create_list(:appointment, 3, :closing, doctor: doctor, user: user) }

      subject { get :history, params: { id: user.id } }

      context 'when the user has closed appointments' do
        it 'assigns the closed appointments to @close_appointments' do
          subject
          expect(assigns(:close_appointments)).to match_array(closed_appointments)
        end

        it 'renders the history template' do
          expect(subject).to render_template(:history)
        end
      end

      context 'when the user has no closed appointments' do
        let(:user_without_appointments) { create(:user) }

        subject { get :history, params: { id: user_without_appointments.id } }

        it 'assigns an empty array to @close_appointments' do
          subject
          expect(assigns(:close_appointments)).to eq([])
        end

        it 'renders the history template' do
          subject
          expect(response).to render_template(:history)
        end
      end
    end
  end

  describe 'unauthorized doctor' do
    describe 'GET #index' do
      subject { get :index }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_doctor_session_path)
      end
    end

    describe 'GET #show' do
      let(:user) { create(:user) }

      subject { get :show, params: { id: user.id } }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_doctor_session_path)
      end
    end

    describe 'GET #history' do
      subject { get :history }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_doctor_session_path)
      end
    end
  end
end
