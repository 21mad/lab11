require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success with" do
      get "/task/show", params: { array: '-1 21 6 28 0 8128 -6 8128 496 28 7 1 6 6' }
      expect(response).to have_http_status(:success)
    end
    it 'returns http redirect without incorrect params' do
      get "/task/show", params: { array: '23 3245 e54s'}
      expect(response).to have_http_status(302)
    end
  end

end
