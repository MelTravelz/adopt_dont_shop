require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)
    
    @pet_1 = @shelter_1.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Maxamus', breed: 'mini-goldendoodle', age: 1, adoptable: true)
    
    @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
    @app_2 = Application.create!(name: "Diana DooLittle", street_address: "124 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
    
    @app_pet_1 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
    @app_pet_2 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
  end

  describe "user story 12" do 
    it "pet_status is set to Waiting by default and can change" do 
      expect(@app_pet_1.pet_status).to eq("Waiting")

      @app_pet_1.pet_status = 1
      expect(@app_pet_1.pet_status).to eq("Approved")
      
      @app_pet_1.pet_status = 2
      expect(@app_pet_1.pet_status).to eq("Denied")
    end

    it "#find_app_pet - returns join table record of specfici app_id & pet_id" do
      expect(ApplicationPet.find_app_pet(@app_1.id, @pet_1.id)).to eq(@app_pet_1)
      expect(ApplicationPet.find_app_pet(@app_2.id, @pet_2.id)).to_not eq(@app_pet_1)
    end
  end
end