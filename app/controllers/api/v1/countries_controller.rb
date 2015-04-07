module Api
  module V1
    class CountriesController < ApplicationController
      before_action :set_reservation, only: [:show, :update, :destroy]
      before_action :setup_errors

      def index
        @countries = Country.all
      end

      def show
        @country = Country.find(params[:id])
      end

      def create
        @country = Country.new(country_params)

        if @country.save
          render 'show', status: :created
        else
          @errors = @country.errors.full_messages * "<br />"
          render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
        end
      end

      def update
        if @country.update(country_params)
          head :no_content
        else
          @errors = @country.errors.full_messages * "<br />"
          render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
        end
      end

      def destroy
        @country.destroy
        head :no_content
      end

      private
      # Setup errors.
      def setup_errors
        @errors = ""
      end

      # DRY.
      def set_country
        @country = Country.find(params[:id])
      end

      # Set constrait on parameters that we get from internetz.
      def country_params
        if params[:country].blank?
          {}
        else
          params.require(:country).permit(:name, :code, :visited)
        end
      end
    end

  end
end
