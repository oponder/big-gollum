require 'spec_helper'

describe InviteUsersController do
  let!(:admin) { create(:user, :admin) }
  before { sign_in(admin) }

  describe '#index' do
    context "no other users" do
      it 'assigns an array of just the admin to users' do

        get :index
        expect(assigns(:users)).to eq([admin])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    context "some other users" do
      it 'assigns and array with all of those users' do
        user1 = create(:user, :normal)
        user2 = create(:user, :normal)
        user3 = create(:user, :normal)

        get :index
        expect(assigns(:users)).to eq([admin, user1, user2, user3])
      end
    end
  end

  describe '#new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user).new_record?).to eq true
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe '#create' do
    context 'without a valid email' do
      before { post :create, {user: {email: "derp"}} }
      it 'rerenders the form' do
        expect(response).to render_template("new")
      end

      it 'sets an error flash' do
        expect(flash[:alert]).to_not be_nil
      end
    end

    context 'with a valid email' do
      before { post :create, {user: {email: "valid@example.com"}} }
      it 'redirects to the index' do
      end

      it 'sets a success flash' do
        expect(flash[:success]).to_not be_nil
      end

      it 'creates a "invited" user' do
        expect(User.count).to eq 2
      end
    end
  end
end