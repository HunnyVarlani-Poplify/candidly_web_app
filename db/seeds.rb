# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# test data 
tenant = Tenant.create!(name: "Admin", subdomain: "admin")

Admin.create!(email: "ajit+admin@poplify.com", first_name: "Ajit", last_name: "Jain",  password:"12345678A", password_confirmation: "12345678A", tenant_id: tenant.id)
Admin.create!(email: "hunny+admin@poplify.com", first_name: "Hunny", last_name: "Varlani",  password:"12345678A", password_confirmation: "12345678A", tenant_id: tenant.id)
Admin.create!(email: "manik+admin@poplify.com", first_name: "Manik", last_name: "Kang",  password:"12345678A", password_confirmation: "12345678A", tenant_id: tenant.id)

tenant1 = Tenant.create(name: "Poplify", subdomain: "poplify")
company = Company.create(name: "Poplify", website: "https://poplify.com", contact_no: "393983", address: "Bus Stand Chandigadh", tenant_id: tenant1.id)
User.create!(name:"Ajit Jain", email:"ajit+1@poplify.com", company_id:company.id, tenant_id: tenant1.id, password:"12345678A", password_confirmation:"12345678A")
