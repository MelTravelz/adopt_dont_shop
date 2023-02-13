require "rails_helper"

RSpec.describe "Admin/Shelters Index Page" do
  describe "when I visit /admin/shelters" do

    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      
      @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    end
  
    it 'user story 10 / should display all shelter names in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      save_and_open_page
    end


  end
end

# if admin=true visible: see All shelters, rev alpha order (US10)
# I see a section of "Shelters with Pending Applications" & in this section, I see the name of every shelter with a pending app (US11)
# test located in the spec for THIS file