require_dependency "subscriptions/application_controller"

module Subscriptions
  class LineItemsController < ApplicationController
    before_action :set_line_item, only: [:show, :edit, :update, :destroy]

    # GET /line_items
    def index
      @line_items = LineItem.all
    end

    # GET /line_items/1
    def show
    end

    # GET /line_items/new
    def new
      @line_item = LineItem.new
    end

    # GET /line_items/1/edit
    def edit
    end

    # POST /line_items
    def create
      @line_item = LineItem.new(line_item_params)

      if @line_item.save
        redirect_to @line_item, notice: 'Line item was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /line_items/1
    def update
      if @line_item.update(line_item_params)
        redirect_to @line_item, notice: 'Line item was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /line_items/1
    def destroy
      @line_item.destroy
      redirect_to line_items_url, notice: 'Line item was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_line_item
        @line_item = LineItem.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def line_item_params
        params.require(:line_item).permit(:description, :amount, :date_added, :invoice_id)
      end
  end
end
