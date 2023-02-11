require "rails_helper"

RSpec.describe "Applications" do
  describe "when I visit /applications/:id" do
    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
      @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create!(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false)
  
      @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
    end

    describe "user story 1 / as a user " do
      it " I see the applicant name, full adress, description, name of all pet( pet name is link to show page), application status" do
        ApplicationPet.create!(application: @app_1, pet: @pet_1)
        visit "/applications/#{@app_1.id}"
        
        expect(page).to have_content("Applicant Name: #{@app_1.name}")
        expect(page).to have_content("Address: #{@app_1.street_address}, #{@app_1.city}, #{@app_1.state}, #{@app_1.zip}")
        expect(page).to have_content("Description: #{@app_1.description}")
        expect(page).to have_content("Pet Name: #{@app_1.pets.first.name}")
        expect(page).to have_content("Status: #{@app_1.status}")
      end

      it " I see pet name that are links to their show page" do 
        ApplicationPet.create!(application: @app_1, pet: @pet_1)
        visit "/applications/#{@app_1.id}"

        expect(page).to have_link("#{@app_1.pets.first.name}", href: "/pets/#{@pet_1.id}")
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end
  end 
end