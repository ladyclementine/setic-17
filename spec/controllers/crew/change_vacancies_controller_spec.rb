require 'rails_helper'

RSpec.describe Crew::ChangeVacanciesController, type: :controller do

  describe "GET #process" do
    it "returns http success" do
      get :process
      expect(response).to have_http_status(:success)
    end
  end

end
