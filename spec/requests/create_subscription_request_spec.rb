require 'rails_helper'

RSpec.describe 'create customer subscription' do
  context 'create a cusotmer subscription - happy path' do
    it 'creates a customer susbscription' do
      tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
      subscription = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
      customer = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")

      params = {
        customer_id: customer.id,
        subscription_id: subscription.id
      }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(params)

      new_customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(CustomerSubscription.count).to eq(1)
      expect(CustomerSubscription.first.customer_id).to eq(customer.id)
      expect(CustomerSubscription.first.subscription_id).to eq(subscription.id)
    end
  end

  context 'create a cusotmer subscription - sad path' do
    context 'when customer_id is not in the database' do
      it 'returns a 400 error message' do
        tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
        subscription = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
  
        params = {
          customer_id: 999,
          subscription_id: subscription.id
        }
        
        headers = { 'CONTENT_TYPE' => 'application/json' }
        
        post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(params)
  
        new_customer_subscription = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
      end
    end
  end
end