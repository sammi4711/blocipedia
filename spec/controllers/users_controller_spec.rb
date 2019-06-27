require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "sign in" do 
    it "logs the user in after sign up" do
      post :create, params: { user: new_user_attributes }
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end
end
