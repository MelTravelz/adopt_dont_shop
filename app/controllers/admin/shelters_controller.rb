class Admin::SheltersController < ApplicationController

  def index
    @shelters_rev_alpha = Shelter.reverse_alpha
    @shelters_filtered_by_pending = Shelter.shelter_names_by_pending_apps
  end
  
end
