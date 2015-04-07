require 'spec_helper'

RSpec.describe Api::V1::CountriesController, :type => :controller do
  render_views

  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    context "when there are countries" do
      before do
        create(:user)
        create(:country, name: 'Afghanistan, Islamic State of')

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
        expect(results.map {|el| el["name"]}).to include('Afghanistan, Islamic State of')
      end
    end
  end
end
