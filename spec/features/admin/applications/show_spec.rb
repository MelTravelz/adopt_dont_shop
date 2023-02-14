require "rails_helper"

RSpec.describe "Admin/applications show Page" do
  describe "when I visit /admin/applications/:id" do

    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      
      @pet_1 = Pet.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true, shelter_id: @shelter_1.id)
      @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
      @pet_3 = Pet.create!(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false, shelter_id: @shelter_2.id)
      @pet_4 = Pet.create!(name: 'Maxamus', breed: 'mini-goldendoodle', age: 1, adoptable: true, shelter_id: @shelter_3.id)

      @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 1)

      ApplicationPet.create!(application: @app_1, pet: @pet_1)
      ApplicationPet.create!(application: @app_1, pet: @pet_4)
    end

    it "user story 12 / approving a pet for adoption" do
      visit "/admin/applications/#{@app_1.id}"

      within "#pet_block-#{@pet_1.id}" do
        expect(page).to have_button("Approve")
        click_button "Approve"
      end
      
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      
      within "#pet_block-#{@pet_1.id}" do
        expect(page).to_not have_button("Approve", visible: :hidden)
        expect(page).to have_content("Pet has been Approved")
      end
    end

    it "user story 13 / rejecting a pet for adoption" do
      visit "/admin/applications/#{@app_1.id}"

      within "#pet_block-#{@pet_1.id}" do
        expect(page).to have_button("Reject")
        click_button "Reject"
      end

      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      
      within "#pet_block-#{@pet_1.id}" do
        expect(page).to_not have_button("Reject", visible: :hidden)
        expect(page).to have_content("Pet has not been Approved")
      end
    end 
  end 
end 