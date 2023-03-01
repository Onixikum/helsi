# frozen_string_literal: true

RSpec.describe Users::HomeController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    before do
      sign_in(user)
      create_list(:appointment, 6, user: user)
    end

    subject { get :show }

    context 'when user is authorized' do
      it 'assigns @open_appointments with pagination' do
        subject
        expect(assigns(:open_appointments)).to eq(user.appointments.opened.paginate(page: 1, per_page: 5))
        expect(assigns(:open_appointments)).to include(Appointment.first)
        expect(assigns(:open_appointments)).not_to include(Appointment.last)
      end

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end
    end

    context 'when user is not authorized' do
      before { sign_out(user) }

      it 'redirects to the sign in page' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
