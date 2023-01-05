require 'rails_helper'

RSpec.describe 'see all subscriptions for a specific customer' do
  context 'when customer does exist and has subscriptions - happy path' do
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

      data = JSON.parse(response.body)["data"]

      expect(data.first["attributes"]["id"]).to eq(subscription_1.id)
      expect(data.first["attributes"]["title"]).to eq(subscription_1.title)
      expect(data.first["attributes"]["price"]).to eq(subscription_1.price)
      expect(data.first["attributes"]["status"]).to eq(subscription_1.status)
      expect(data.first["attributes"]["frequency"]).to eq(subscription_1.frequency)
      expect(data.first["attributes"]["tea_id"]).to eq(subscription_1.tea_id)

      expect(data.last["attributes"]["id"]).to eq(subscription_2.id)
      expect(data.last["attributes"]["title"]).to eq(subscription_2.title)
      expect(data.last["attributes"]["price"]).to eq(subscription_2.price)
      expect(data.last["attributes"]["status"]).to eq(subscription_2.status)
      expect(data.last["attributes"]["frequency"]).to eq(subscription_2.frequency)
      expect(data.last["attributes"]["tea_id"]).to eq(subscription_2.tea_id)
    end
  end

  context 'when customer does exist and has NO subscriptions - happy path' do
    it 'returns and empty array' do
      tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
      tea_2 = Tea.create!(title: "Sleepy Time", description: "comforting, balanced", temperature: 145, brew_time: 180)
      subscription_1 = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
      subscription_2 = Subscription.create!(title: "Lavendar weekly", price: 1.50, status: "active", frequency: 7, tea_id: tea.id)
      subscription_3 = Subscription.create!(title: "Sleepy Time weekly", price: 2.00, status: "active", frequency: 7, tea_id: tea_2.id)
      customer_1 = Customer.create!(first_name: "Thomas", last_name: "Hayes", email: "thomas@aol.com", street_address: "5425 Main St", city: "Broomfield", state: "Colorado", zip_code: "80020")
      customer_2 = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")
      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_1.id)
      customer_subscription_2 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_2.id)
      customer_subscription_3 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_3.id)

      get "/api/v1/customers/#{customer_1.id}/subscriptions"

      all_customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      
      data = JSON.parse(response.body)["data"]
      expect(data).to eq([])
    end
  end

  context 'when customer does NOT exist - sad path' do
    it 'returns and error message ' do
      tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
      tea_2 = Tea.create!(title: "Sleepy Time", description: "comforting, balanced", temperature: 145, brew_time: 180)
      subscription_1 = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
      subscription_2 = Subscription.create!(title: "Lavendar weekly", price: 1.50, status: "active", frequency: 7, tea_id: tea.id)
      subscription_3 = Subscription.create!(title: "Sleepy Time weekly", price: 2.00, status: "active", frequency: 7, tea_id: tea_2.id)
      customer_1 = Customer.create!(first_name: "Thomas", last_name: "Hayes", email: "thomas@aol.com", street_address: "5425 Main St", city: "Broomfield", state: "Colorado", zip_code: "80020")
      customer_2 = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")
      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_1.id)
      customer_subscription_2 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_2.id)
      customer_subscription_3 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_3.id)

      get "/api/v1/customers/999/subscriptions"

      all_customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
  end
end
