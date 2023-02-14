require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
    @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
    @app_pet = ApplicationPet.create!(application: @app_1, pet: @pet_1, pet_status: 0)
  end

  describe "user story 12" do 
    it "pet_status is set to In Progress by default and can change" do 
      expect(@app_pet.pet_status).to eq("In Progress")

      @app_pet.pet_status = 1
      expect(@app_pet.pet_status).to eq("Accepted")
      
      @app_pet.pet_status = 2
      expect(@app_pet.pet_status).to eq("Rejected")
    end
  end
end