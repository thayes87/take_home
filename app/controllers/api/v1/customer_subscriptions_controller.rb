class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
   customer_subscription = CustomerSubscription.create!(customer_subscription_params)
   render json: CustomerSubscriptionSerializer.new(customer_subscription)
  end

  private
  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end