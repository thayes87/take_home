require 'rails_helper'

RSpec.describe 'delete customer subscription' do
  context 'when customer subscription exists - happy path' do
    it 'destroys the customer susbscription and returns a 200' do
      tea = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
      subscription = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea.id)
      customer = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")
      customer_subscription = CustomerSubscription.create!(customer_id: customer.id, subscription_id: subscription.id)
      
      expect(CustomerSubscription.count).to eq(1)
            
      delete "/api/v1/customer_subscriptions/#{customer_subscription.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(CustomerSubscription.count).to eq(0)
      expect(Subscription.count).to eq(1)
      expect(Customer.count).to eq(1)
    end
  end

  context 'when customer subscription does not exist - sad path' do
    it 'returns a error message with status 400' do
      
      expect(CustomerSubscription.count).to eq(0)
      
      delete "/api/v1/customer_subscriptions/999"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
  end
end