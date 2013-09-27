require_dependency "subscriptions/application_controller"

module Subscriptions
  class CustomersController < ApplicationController

    def index
      @customers = Subscriptions.customer_class.all
    end

  end
end
