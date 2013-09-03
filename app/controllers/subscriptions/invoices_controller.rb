require_dependency "subscriptions/application_controller"

module Subscriptions
  class InvoicesController < ApplicationController
    before_action :set_invoice, only: [:show, :edit, :update, :destroy]

    # GET /invoices
    def index
      @invoices = Invoice.all
    end

    # GET /invoices/1
    def show
    end

    # GET /invoices/new
    def new
      @invoice = Invoice.new
    end

    # GET /invoices/1/edit
    def edit
    end

    # POST /invoices
    def create
      @invoice = Invoice.new(invoice_params)

      if @invoice.save
        redirect_to @invoice, notice: 'Invoice was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /invoices/1
    def update
      if @invoice.update(invoice_params)
        redirect_to @invoice, notice: 'Invoice was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /invoices/1
    def destroy
      @invoice.destroy
      redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_invoice
        @invoice = Invoice.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def invoice_params
        params.require(:invoice).permit(:invoice_start_date, :invoice_end_date, :customer_id)
      end
  end
end
