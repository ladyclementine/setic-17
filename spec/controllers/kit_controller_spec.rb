require 'rails_helper'

RSpec.describe KitController, type: :controller do

  describe "GET #select" do
    it "returns http success" do
      get :select
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #remove" do
    it "returns http success" do
      get :remove
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
