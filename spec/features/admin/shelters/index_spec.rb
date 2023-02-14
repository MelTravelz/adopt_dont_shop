require "rails_helper"

RSpec.describe "Admin/Shelters Index Page" do
  describe "when I visit /admin/shelters" do

    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      
      @pet_1 = Pet.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true, shelter_id: @shelter_1.id)
      @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
      @pet_3 = Pet.create!(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false, shelter_id: @shelter_2.id)
      @pet_4 = Pet.create!(name: 'Maxamus', breed: 'mini-goldendoodle', age: 1, adoptable: true, shelter_id: @shelter_3.id)

      @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 1)
      @app_2 = Application.create!(name: "Diana DooLittle", street_address: "124 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog too", status: 1)

      ApplicationPet.create!(application: @app_1, pet: @pet_1)
      ApplicationPet.create!(application: @app_1, pet: @pet_4)

      ApplicationPet.create!(application: @app_2, pet: @pet_2)
      ApplicationPet.create!(application: @app_2, pet: @pet_4)
    end
  
    it 'user story 10 / should display all shelter names in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it 'user story 11 / I see Shelters with Pending Apps and shelter names who have a pending app' do
      visit '/admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")

      within("#shelters_with_pending_apps") do
        expect(page).to have_content("-#{@shelter_3.name}")
        expect(page).to have_content("-#{@shelter_1.name}")
        expect(page).to_not have_content(@shelter_2.name)
      end
    end

  end
end



