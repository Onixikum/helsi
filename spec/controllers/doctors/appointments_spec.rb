# frozen_string_literal: true

RSpec.describe Doctors::AppointmentsController, type: :controller do
  describe 'authorized user' do
    let(:user) { create(:user) }
    let(:doctor) { create(:doctor) }
    let(:appointment) { create(:appointment, user: user, doctor: doctor) }

    before { sign_in doctor }

    describe 'GET #index' do
      let(:category) { create(:category) }

      before do
        create_list(:appointment, 6, :closing, user: user, doctor: doctor)
        create(:specialization, doctor: doctor, category: category)
      end

      subject { get :index }

      it 'assigns @appointments with pagination' do
        subject
        expect(assigns(:appointments)).to eq(user.appointments.closed.paginate(page: 1, per_page: 5))
        expect(assigns(:appointments)).to include(Appointment.first)
        expect(assigns(:appointments)).not_to include(Appointment.last)
      end

      it 'assigns @categories' do
        subject
        expect(assigns(:categories)).to eq([category])
      end

      it 'renders the index template' do
        expect(subject).to render_template(:index)
      end
    end

    describe 'PATCH #update' do
      let(:params) do
        {
          id: appointment.id,
          appointment: {
            recommendation: Faker::Lorem.paragraph_by_chars
          }
        }
      end

      subject { patch :update, params: params }

      it 'updates the appointment with recommendation' do
        subject
        appointment.reload
        expect(appointment.aasm_state).to eq('closing')
        expect(appointment.recommendation).to eq(params[:appointment][:recommendation])
      end

      it 'flashes success message' do
        subject
        expect(flash[:success]).to eq('Recommendations are provided!')
      end

      context 'when appointment is not updated' do
        let(:params) do
          {
            id: appointment.id,
            appointment: {
              recommendation: ''
            }
          }
        end

        subject { patch :update, params: params }

        it 'flashes error message' do
          subject
          expect(flash[:error]).to eq('Something went wrong! Choose an appointment and provide recommendations.')
        end
      end

      it 'redirects to the doctor root path' do
        expect(subject).to redirect_to(doctor_root_path)
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
  end
end
