require 'spec_helper'

RSpec.describe Api::V1::CurrenciesController, :type => :controller do
  render_views

  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    context "when there are tables" do
      before do
        create(:currency, name: 'Afghani')

        xhr :get, :index, format: :json
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return one result' do
        expect(results.size).to eq(1)
      end

      it "should include 'Afghani'" do
        expect(results.map {|el| el["name"]}).to include('Afghani')
      end
    end
  end
end