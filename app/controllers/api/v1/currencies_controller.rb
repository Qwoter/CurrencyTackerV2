module Api
  module V1
    class CurrenciesController < ApplicationController
      skip_before_filter :verify_authenticity_token

      def index
        @currencies = Currency.all
      end

      def show
        @currency = Currency.find(params[:id])
      end
    end
  end
end
