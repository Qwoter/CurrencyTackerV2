require 'spec_helper'

RSpec.describe Api::V1::CurrenciesController, :type => :controller do
  render_views

  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    context "when there are currencies" do
      before do
        user = create(:user)
        @currency = create(:currency, code: 'us')

        request.headers["X-Api-Key"] = user.api_key
        xhr :get, :index, format: :json
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return one result' do
        expect(results.size).to eq(1)
      end

      it "should include 'Afghani'" do
        expect(results.map {|el| el["code"]}).to include(@currency.code)
      end
    end
  end


  describe "show" do
    subject(:results) { JSON.parse(response.body) }

    context "when there is 1 currency" do
      before do
        user = create(:user)
        @currency = create(:leu, user: user)

        request.headers["X-Api-Key"] = user.api_key
        xhr :get, :show, format: :json, id: @currency.code
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return one result' do
        expect(results.size).to eq(7)
      end

      it "should include name of currency" do
        expect(results.inspect).to include(@currency.name)
      end
    end
  end

  describe "destroy" do
    context "destroy currency" do
      before do
        @user = create(:user)
        @currency = create(:leu, user: @user)

        request.headers["X-Api-Key"] = @user.api_key
        xhr :delete, :destroy, format: :json, id: @currency.code
      end

      it 'should 204' do
        expect(response.status).to eq(204)
      end

      it 'should not find destroyed currency' do
        expect(Currency.where({code: @currency.code, user: @user.id}).size).to eq(0)
      end
    end
  end

  describe "create" do
    before do
      @user = create(:user)
      @country = create(:country, user: @user_id)
      @currency = build(:leu, user: @user, country: @country)

      request.headers["X-Api-Key"] = @user.api_key
      xhr :post, :create, format: :json, currency: { weight: @currency.weight, collector_value: @currency.collector_value, name: @currency.name, code: @currency.code, country_id: @country.code }
    end

    it 'should 201' do
      expect(response.status).to eq(201)
    end

    it 'should find created currency' do
      expect(Currency.where({code: @currency.code, user: @user.id}).size).to eq(1)
    end
  end

  describe "update" do
    context "on successful update" do
      before do
        @user = create(:user)
        @currency = create(:leu, user: @user)

        request.headers["X-Api-Key"] = @user.api_key
        xhr :put, :update, format: :json, id: @currency.code, currency: { name: "Leo" }
        @currency.reload
      end

      it 'should 204' do
        expect(response.status).to eq(204)
      end

      it 'should see updated changes' do
        expect(@currency.name).to eq("Leo")
      end
    end
  end
end
