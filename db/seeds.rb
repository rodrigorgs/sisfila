# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rodada.create!(descricao: "SISFILA") if Rodada.count == 0
User.create(email: "admin@example.com", superadmin_role: true, password: "admin2222", password_confirmation: "admin2222")
