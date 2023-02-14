class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates :name, presence: true
  validates :age, presence: true, numericality: true


  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  # def self.find_pet(pet_name)
  #   where("name ILIKE ?", "%#{pet_name}%")
  # end

  def app_pet_status(app_id)
    # require 'pry'; binding.pry
    application_pets.where(application_id: app_id).pluck(:pet_status).first
  end

end
