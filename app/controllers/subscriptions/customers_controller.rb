require_dependency "subscriptions/application_controller"

module Subscriptions
  class CustomersController < ApplicationController

    def index
      @customers = Subscriptions.customer_class.all
    end

    def show
      @customer = Subscriptions.customer_class.find(params[:id])
    end

  end
end
