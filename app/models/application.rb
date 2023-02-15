class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  
  validates_presence_of :name, presence: true
  validates_presence_of :street_address, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true
  validates :zip, presence: true, numericality: true
  # This was unable to be validated... but why? 
  # validates_length_of :zip, is: 5
  validates_presence_of :description, presence: true

  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
end