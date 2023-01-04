class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
   customer_subscription = CustomerSubscription.find_or_initialize_by(customer_subscription_params)
   if customer_subscription.save
    render json: CustomerSubscriptionSerializer.new(customer_subscription)
   else
    render :json => { error: "No record found", status: 400 }, :status => :bad_request
   end
  end

  private
  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end