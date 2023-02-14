require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_numericality_of :zip }
    it { should validate_presence_of :description }
  end

  before(:each) do
    # @shelter_1 = Shelter.create(name: 'Petz R Us', city: 'Denver, CO', foster_program: false, rank: 9)
    # @pet_1 = @shelter_1.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
    # @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    # @pet_3 = @shelter_1.pets.create!(name: 'Pamuk', breed: 'english springer spaniel', age: 3, adoptable: false)

    @app_1 = Application.create!(name: "Joe Shmow", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "I want a dog", status: 0)
  end

  describe "user story 1" do 
    it "status is set to In Progress by default and can change" do 
      expect(@app_1.status).to eq("In Progress")

      @app_1.status = 1
      expect(@app_1.status).to eq("Pending")
    
      @app_1.status = 2
      expect(@app_1.status).to eq("Accepted")
       
      @app_1.status = 3
      expect(@app_1.status).to eq("Rejected")
    end
  end
end