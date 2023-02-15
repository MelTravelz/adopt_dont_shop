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
      @app_2 = Application.create!(name: "Joe the other Shmow", street_address: "121 Main St", city: "Boston", state: "MA", zip: 12346, description: "I also want dog", status: 1)
      
      ApplicationPet.create!(application: @app_1, pet: @pet_1)
      ApplicationPet.create!(application: @app_1, pet: @pet_4)

      ApplicationPet.create!(application: @app_2, pet: @pet_2)
      ApplicationPet.create!(application: @app_2, pet: @pet_4)
    end

    it "user story 12 / approving a pet for a single application" do
      visit "/admin/applications/#{@app_1.id}"

      within "#pet_block-#{@pet_1.id}" do
        expect(page).to have_button("Approve this Pet")
        click_button "Approve this Pet"
      end
      
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      
      within "#pet_block-#{@pet_1.id}" do
        expect(page).to_not have_button("Approve this Pet", visible: :hidden)
        expect(page).to have_content("#{@pet_1.name} has been Approved for this Application")
      end
    end

    it "user story 13 / rejecting a pet for a single application" do
      visit "/admin/applications/#{@app_1.id}"

      within "#pet_block-#{@pet_1.id}" do
        expect(page).to have_button("Deny this Pet")
        click_button "Deny this Pet"
      end

      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      
      within "#pet_block-#{@pet_1.id}" do
        expect(page).to_not have_button("Deny this Pet", visible: :hidden)
        expect(page).to have_content("#{@pet_1.name} has been Denied for this Application")
      end
    end 

    it "user story 14 / Button varification for two app show pages " do
      visit "/admin/applications/#{@app_1.id}"

      within "#pet_block-#{@pet_4.id}" do
        expect(page).to have_button("Deny this Pet")
        click_button "Deny this Pet"
      end

      visit "/admin/applications/#{@app_2.id}"
      
      within "#pet_block-#{@pet_4.id}" do
        expect(page).to have_button("Deny this Pet")
        expect(page).to have_button("Approve this Pet")
      end
    end 

    describe "add partials / as a user " do
      it "I see the applicant name, full adress, description, application status from a partial" do
        visit "/admin/applications/#{@app_1.id}"
        
        expect(page).to have_content("Status: #{@app_1.status}")
        expect(page).to have_content("Applicant Name: #{@app_1.name}")
        expect(page).to have_content("Address: #{@app_1.street_address}, #{@app_1.city}, #{@app_1.state}, #{@app_1.zip}")
        expect(page).to have_content("Description: #{@app_1.description}")
      end
    end
  end 
end 