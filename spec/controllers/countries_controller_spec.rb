require 'spec_helper'

RSpec.describe Api::V1::CountriesController, :type => :controller do
  render_views

  describe "authentication" do
    subject(:results) { JSON.parse(response.body) }

    it 'should 200' do
      user = create(:user)
      create(:country)

      request.headers["X-Api-Key"] = user.api_key
      xhr :get, :index, format: :json

      expect(response.status).to eq(200)
    end

    it 'should 401' do
      user = create(:user)
      create(:country)

      request.headers["X-Api-Key"] = "random string"
      xhr :get, :index, format: :json

      expect(response.status).to eq(401)
    end
  end

  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    context "when there are countries" do
      before do
        user = create(:user)
        10.times { create(:country, name: 'Afghanistan, Islamic State of') }

        request.headers["X-Api-Key"] = user.api_key
        xhr :get, :index, format: :json
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return ten results' do
        expect(results.size).to eq(10)
      end

      it "should include 'Afghani'" do
        expect(results.map {|el| el["name"]}).to include('Afghanistan, Islamic State of')
      end
    end
  end

  describe "show" do
    subject(:results) { JSON.parse(response.body) }

    context "when there is 1 country" do
      before do
        user = create(:user)
        country = create(:afghanistan, user: user)

        request.headers["X-Api-Key"] = user.api_key
        xhr :get, :show, format: :json, id: country.code
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return one result' do
        expect(results.size).to eq(3)
      end

      it "should include 'Afghani'" do
        expect(results.inspect).to include('Afghanistan, Islamic State of')
      end
    end
  end

  describe "destroy" do
    context "destroy country" do
      before do
        @user = create(:user)
        @country = create(:afghanistan, user: @user)

        request.headers["X-Api-Key"] = @user.api_key
        xhr :delete, :destroy, format: :json, id: @country.code
      end

      it 'should 204' do
        expect(response.status).to eq(204)
      end

      it 'should not find destroyed country' do
        expect(Country.where({code: @country.code, user: @user.id}).size).to eq(0)
      end
    end
  end

  describe "create" do
    before do
      @user = create(:user)
      @country = build(:afghanistan, user: @user)

      request.headers["X-Api-Key"] = @user.api_key
      xhr :post, :create, format: :json, country: { name: @country.name, code: @country.code, visited: @country.visited }
    end

    it 'should 201' do
      expect(response.status).to eq(201)
    end

    it 'should find created country' do
      expect(Country.where({code: @country.code, user: @user.id}).size).to eq(1)
    end
  end

  describe "update" do
    context "on successful update" do
      before do
        @user = create(:user)
        @country = create(:afghanistan, user: @user)

        request.headers["X-Api-Key"] = @user.api_key
        xhr :put, :update, format: :json, id: @country.code, country: { name: "Avalon" }
        @country.reload
      end

      it 'should 204' do
        expect(response.status).to eq(204)
      end

      it 'should see updated changes' do
        expect(@country.name).to eq("Avalon")
      end
    end
  end

  describe "country_list" do
    subject(:results) { JSON.parse(response.body) }

    context "when getting unvisited countries" do
      before do
        @user = create(:user)
        @currency_a = create(:a, user: @user)
        @currency_b = create(:b, user: @user)
        @currency_c = create(:c, user: @user)
        @currency_d = create(:d, user: @user)

        request.headers["X-Api-Key"] = @user.api_key
        xhr :get, :country_list, format: :json, max_weight: 16
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should see updated changes' do
        expect(response.body).to include("\"amount\":4.0},{\"name\":\"B\"")
      end
    end
  end
end
