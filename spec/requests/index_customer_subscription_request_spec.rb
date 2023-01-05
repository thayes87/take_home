require 'rails_helper'

RSpec.describe 'see all subscriptions for a specific customer' do
  context 'when customer does exist - happy path' do
    it 'returns all the subscriptions for the given customer' do
      tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
      tea_2 = Tea.create!(title: "Sleepy Time", description: "comforting, balanced", temperature: 145, brew_time: 180)
      subscription_1 = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
      subscription_2 = Subscription.create!(title: "Lavendar weekly", price: 1.50, status: "active", frequency: 7, tea_id: tea.id)
      subscription_3 = Subscription.create!(title: "Sleepy Time weekly", price: 2.00, status: "active", frequency: 7, tea_id: tea_2.id)
      customer_1 = Customer.create!(first_name: "Thomas", last_name: "Hayes", email: "thomas@aol.com", street_address: "5425 Main St", city: "Broomfield", state: "Colorado", zip_code: "80020")
      customer_2 = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")
      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_1.id)
      customer_subscription_2 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_2.id)
      customer_subscription_3 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_3.id)
      
      get "/api/v1/customers/#{customer_2.id}/subscriptions"

      all_customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_2.subscriptions.count).to eq(2)
      expect(customer_2.subscriptions.last.id).to eq(subscription_2.id)
      expect(customer_2.subscriptions.first.id).to eq(subscription_1.id)
    end
  end
end
