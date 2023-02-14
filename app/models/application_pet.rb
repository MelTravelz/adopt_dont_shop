class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum pet_status: ["Waiting", "Approved", "Denied"]

  def self.find_app_pet(app_id, pet_id)
    where(application_id: app_id, pet_id: pet_id).first
  end
end