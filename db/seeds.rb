# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tea_1 = Tea.create!(title: "Lavender", description: "calming, soothing", temperature: 180, brew_time: 150)
tea_2 = Tea.create!(title: "Sleepy Time", description: "comforting, balanced", temperature: 145, brew_time: 180)
tea_3 = Tea.create!(title: "Earl Grey", description: "envigorating, smooth", temperature: 200, brew_time: 140)

subscription_1 = Subscription.create!(title: "Lavendar weekly", price: 1.50, status: "active", frequency: 7, tea_id: tea_1.id)
subscription_2 = Subscription.create!(title: "Lavendar monthly", price: 5.50, status: "active", frequency: 28, tea_id: tea_1.id)
subscription_3 = Subscription.create!(title: "Sleepy Time weekly", price: 2.00, status: "active", frequency: 7, tea_id: tea_2.id)
subscription_4 = Subscription.create!(title: "Sleepy Time monthly", price: 7.25, status: "active", frequency: 28, tea_id: tea_2.id)
subscription_5 = Subscription.create!(title: "Early Grey weekly", price: 1.25, status: "active", frequency: 7, tea_id: tea_3.id)
subscription_6 = Subscription.create!(title: "Early Grey monthly", price: 4.00, status: "active", frequency: 28, tea_id: tea_3.id)

customer_1 = Customer.create!(first_name: "Thomas", last_name: "Hayes", email: "thomas@aol.com", street_address: "5425 Main St", city: "Broomfield", state: "Colorado", zip_code: "80020")
customer_2 = Customer.create!(first_name: "Ben", last_name: "Franklin", email: "BF@aol.com", street_address: "123 South 1st St", city: "Jasper", state: "Ohio", zip_code: "16905")
customer_3 = Customer.create!(first_name: "Steve", last_name: "Lessler", email: "Steveknows@aol.com", street_address: "633 N. Rampart blvd", city: "Munich", state: "Washington", zip_code: "99845")
