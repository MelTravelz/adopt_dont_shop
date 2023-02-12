require "rails_helper"

RSpec.describe "Applications" do
  describe "when I visit /applications/:id" do
    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
      @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create!(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false)
      @pet_4 = @shelter_1.pets.create!(name: 'Maxamus', breed: 'mini-goldendoodle', age: 1, adoptable: true)
      @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
      ApplicationPet.create!(application: @app_1, pet: @pet_1)
    end

    describe "user story 1 / as a user " do
      it " I see the applicant name, full adress, description, name of all pet( pet name is link to show page), application status" do
        visit "/applications/#{@app_1.id}"
        
        expect(page).to have_content("Applicant Name: #{@app_1.name}")
        expect(page).to have_content("Address: #{@app_1.street_address}, #{@app_1.city}, #{@app_1.state}, #{@app_1.zip}")
        expect(page).to have_content("Description: #{@app_1.description}")
        expect(page).to have_content("Pet Name: #{@app_1.pets.first.name}")
        expect(page).to have_content("Status: #{@app_1.status}")
      end

      it " I see pet name that are links to their show page" do 
        visit "/applications/#{@app_1.id}"

        expect(page).to have_link("#{@app_1.pets.first.name}", href: "/pets/#{@pet_1.id}")
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end

    describe "user story 4 / as a user " do
      it " I see a section on the page to Add a Pet to this Application and display pet name " do
        visit "/applications/#{@app_1.id}"
        
        expect(page).to have_content("Add a Pet to this Application")
        
        fill_in("Search by pet name:", with: "Max")
        click_button("Search")

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Max")
      end
    end 

    describe "user story 5 / as a user " do 
      it "I see any pet whose name PARTIALLY matches my search " do
        visit "/applications/#{@app_1.id}"

        fill_in("Search by pet name:", with: "Max")
        click_button("Search")
        
        within("#adoption-#{@pet_1.id}") do
          expect(page).to have_button("Adopt this Pet")
          click_button("Adopt this Pet")
        end 

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Pet Name: Max")

      end 
    end

    describe "user story 6 / as a user " do 
      it "after I add 1+ pets, I see a button to submit the application" do
        visit "/applications/#{@app_1.id}"

        fill_in("Search by pet name:", with: "Max")
        click_button("Search")

        # expect(page).to_not have_button("Submit Adoption Application")

        within("#adoption-#{@pet_4.id}") do
          click_button("Adopt this Pet")
        end 

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_button("Submit Adoption Application")
      end

      it "after I click the submit app button, I see status pending, pets I want to adopt, and NOT the add pet section or submit button" do
        visit "/applications/#{@app_1.id}"

        fill_in("Search by pet name:", with: "Max")
        click_button("Search")
        
        within("#adoption-#{@pet_1.id}") do
          expect(page).to have_button("Adopt this Pet")
          click_button("Adopt this Pet")
        end 

        click_button("Submit Adoption Application")
        expect(current_path).to eq("/applications/#{@app_1.id}")

        expect(page).to have_content("Pending")
      end
    end

    describe "User story 8 / as a user " do 
      it " I see any pet whose name PARTIALLY matches my search " do
        visit "/applications/#{@app_1.id}"
                
        fill_in("Search by pet name:", with: "Ma")
        click_button("Search")

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Max")
        expect(page).to have_content("Maxamus")
      end 
    end

    describe "User story 9 / as a user " do 
      it " I see my pet search is case insensitive" do
        visit "/applications/#{@app_1.id}"
                
        fill_in("Search by pet name:", with: "pAmuK")
        click_button("Search")

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Pamuk")
      end 
    end
  end 
end