require 'rails_helper'

RSpec.describe 'the new application form' do
  describe "when I visit /application/new" do

    describe "user story 2 / as a user " do
      it "can post a new applicaiton" do
        visit 'applications/new'
        
        expect(page).to have_content("Application Form")
        expect(page).to have_field(:name)
        expect(page).to have_field(:street_address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip)
        expect(page).to have_field(:description)
        expect(page).to have_button("Submit")

        fill_in("Name", with: "Diana Doolittle")
        fill_in("Street Address", with: "123 My Street")
        fill_in("City", with: "Buena Vista")
        fill_in("State", with: "CO")
        fill_in("Zip", with: "12345")
        fill_in("Description", with: "I want another mini-goldendoodle")
      
        click_button("Submit")
        expect(current_path).to eq("/applications/#{Application.last.id}")
        
        expect(page).to have_content("Diana Doolittle")
        expect(page).to have_content("123 My Street")
        expect(page).to have_content("Buena Vista")
        expect(page).to have_content("CO")
        expect(page).to have_content("12345")
        expect(page).to have_content("I want another mini-goldendoodle")
        expect(page).to have_content("In Progress")
      end
    end

    describe "user story 3 / as a user " do
      it "can NOT post a new applicaiton without a name" do
        visit 'applications/new'

        fill_in("Street Address", with: "123 My Street")
        fill_in("City", with: "Buena Vista")
        fill_in("State", with: "CO")
        fill_in("Zip", with: "12345")
        fill_in("Description", with: "I want another mini-goldendoodle")

        click_button("Submit")

        expect(page).to have_content("Application Form")
        expect(page).to have_field(:name)
        expect(page).to have_field(:street_address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip)
        expect(page).to have_field(:description)
        expect(page).to have_button("Submit")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end

