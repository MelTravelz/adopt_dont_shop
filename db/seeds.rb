# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
# Shelters:
shelter_1 = Shelter.create(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)

# Pets:
pet_1 = shelter_1.pets.create(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'mut', age: 3, adoptable: true)
pet_3 = shelter_1.pets.create(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false)
pet_4 = shelter_1.pets.create(name: 'Maxamus', breed: 'mini-goldendoodle', age: 1, adoptable: true)

