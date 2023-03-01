# frozen_string_literal: true

RSpec.describe Users::CategoriesController, type: :controller do
  describe 'authorized user' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    before { sign_in(user) }

    describe 'GET #index' do
      let!(:categories) do
        build_list(:category, 5) do |category|
          category.name = Faker::Lorem.sentence
          category.save!
        end
      end

      subject { get :index }

      it 'renders the index template' do
        subject
        expect(response).to render_template(:index)
      end

      it 'assigns @categories' do
        subject
        expect(assigns(:categories)).to eq(categories.sort_by(&:name))
      end
    end

    describe 'GET #show' do
      let!(:doctors) do
        create_list(:doctor, 5)
      end

      before do
        doctors.map do |doctor|
          create(:specialization, doctor: doctor, category: category)
        end
        get :show, params: { id: category.id }
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'assigns @doctors' do
        expect(assigns(:doctors)).to eq(doctors.reverse)
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

    describe 'GET #show' do
      let(:category) { create(:category) }

      subject { get :show, params: { id: category.id } }

      it 'redirects to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
