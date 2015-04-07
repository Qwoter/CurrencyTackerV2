module Api
  module V1
    class CurrenciesController < ApplicationController
      before_action :authenticate
      before_action :set_currency, only: [:show, :update, :destroy]
      before_action :setup_errors

      def index
        @currencies = Currency.all
      end

      def show
      end

      def create
        pars = { :user_id => @user.id }.merge currency_params
        @currency = Currency.new(pars)

        if @currency.save
          head :created
        else
          @errors = @currency.errors.full_messages * "<br />"
          render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
        end
      end

      def update
        if @currency.update(currency_params)
          head :no_content
        else
          @errors = @currency.errors.full_messages * "<br />"
          render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
        end
      end

      def destroy
        @currency.destroy
        head :no_content
      end

      private
      # Setup errors.
      def setup_errors
        @errors = ""
      end

      # DRY.
      def set_currency
        @currency = Currency.find_first(params[:id], @user.id)
      end

      # Set constrait on parameters that we get from internetz.
      def currency_params
        if params[:currency].blank?
          {}
        else
          params.require(:currency).permit(:code, :name, :country_id, :weight, :collector_value)
        end
      end
    end

  end
end