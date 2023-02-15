class ApplicationPetsController < ApplicationController

  def create
    ApplicationPet.create!(applicaton_pets_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  private 
  
  def applicaton_pets_params
    params.permit(:application_id, :pet_id)
  end
end