require_dependency "subscriptions/application_controller"

module Subscriptions
  class PlansController < ApplicationController
    before_filter :set_plan, only: [:show, :edit, :update, :destroy]

    # GET /plans
    def index
      @plans = Plan.all
    end

    # GET /plans/1
    def show
    end

    # GET /plans/new
    def new
      @plan = Plan.new
    end

    # GET /plans/1/edit
    def edit
    end

    # POST /plans
    def create
      @plan = Plan.new(plan_params)

      if @plan.save
        redirect_to @plan, notice: 'Plan was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /plans/1
    def update
      if @plan.update(plan_params)
        redirect_to @plan, notice: 'Plan was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /plans/1
    def destroy
      @plan.destroy
      redirect_to plans_url, notice: 'Plan was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_plan
        @plan = Plan.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def plan_params
        params.require(:plan).permit(:name, :amount, :interval_quantity, :interval_units, :trial_period_days, :assigned_id, :group_id)
      end
  end
end
