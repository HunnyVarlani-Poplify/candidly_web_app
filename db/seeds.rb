# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# test data 
Tenant.create!(id:1, name: "Admin", subdomain: "admin")

Admin.create!(id:1, email: "ajit+admin@poplify.com", first_name: "Ajit", last_name: "Jain",  password:"12345678A", password_confirmation: "12345678A", tenant_id: 1)
Admin.create!(id:2, email: "hunny+admin@poplify.com", first_name: "Hunny", last_name: "Varlani",  password:"12345678A", password_confirmation: "12345678A", tenant_id: 1)
Admin.create!(id:3, email: "manik+admin@poplify.com", first_name: "Manik", last_name: "Kang",  password:"12345678A", password_confirmation: "12345678A", tenant_id: 1)

Tenant.create(id:2, name: "Poplify", subdomain: "poplify")
Company.create(id:1, name: "Poplify", website: "https://poplify.com", contact_no: "393983", address: "Bus Stand Chandigadh", tenant_id: 2)
User.create!(id:1, name:"Ajit Jain", email:"ajit@poplify.com", company_id:1, tenant_id: 2, password:"12345678A", password_confirmation:"12345678A")

