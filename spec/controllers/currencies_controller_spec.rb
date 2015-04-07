require 'spec_helper'

RSpec.describe Api::V1::CurrenciesController, :type => :controller do
  render_views

  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    context "when there are currencies" do
      before do
        create(:user)
        create(:currency, code: 'AFA')

        request.headers["X-Api-Key"] = "f651dde722b0e21c291843b4f2f63d16"
        xhr :get, :index, format: :json
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return one result' do
        expect(results.size).to eq(1)
      end

      it "should include 'Afghani'" do
        expect(results.map {|el| el["code"]}).to include('AFA')
      end
    end
  end
end
