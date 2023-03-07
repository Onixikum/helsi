# frozen_string_literal: true

RSpec.describe Users::AppointmentsController, type: :controller do
  describe 'authorized user' do
    let(:user) { create(:user) }
    let(:doctor) { create(:doctor) }

    describe 'GET #index' do
      before do
        sign_in user
        create_list(:appointment, 10, :closing, user: user, doctor: doctor)
        create_list(:appointment, 5, user: user, doctor: doctor)
      end

      subject { get :index }

      it 'assigns @close_appointments' do
        subject
        expect(assigns(:close_appointments)).to eq(user.appointments.closed.paginate(page: 1, per_page: 5))
      end

      it 'renders the index template' do
        subject
        expect(response).to render_template(:index)
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        let(:params) do
          {
            appointment: {
              doctor_id: doctor.id,
              appointment_date: Time.zone.now,
              symptoms: Faker::Lorem.paragraph_by_chars
            }
          }
        end

        before do
          sign_in user
          post :create, params: params
        end

        it 'creates a new appointment' do
          expect { post :create, params: params }
            .to change(user.appointments, :count).by(1)
        end

        it 'sets a success flash message' do
          expect(flash[:success]).to eq("A doctor's appointment has been created!")
        end

        it 'redirects to user root path' do
          expect(response).to redirect_to(user_root_path)
        end
      end

      context 'with invalid attributes' do
        let(:params) do
          {
            appointment: {
              doctor_id: doctor.id,
              appointment_date: Time.zone.now,
              symptoms: ''
            }
          }
        end

        before do
          sign_in user
          post :create, params: params
        end

        it 'does not create a new appointment' do
          expect { post :create, params: params }
            .to_not change(user.appointments, :count)
        end

        it 'sets an error flash message' do
          expect(flash[:error]).to eq('Something went wrong! Choose a doctor and describe your symptoms.')
        end

        it 'redirects to users categories path' do
          expect(response).to redirect_to(users_categories_path)
        end
      end
    end
  end

  describe 'unauthorized user' do
    describe 'GET #index' do
      subject { get :index }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
