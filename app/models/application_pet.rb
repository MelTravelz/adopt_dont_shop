class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum pet_status: ["In Progress", "Accepted", "Rejected"]

end