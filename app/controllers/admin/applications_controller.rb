class Admin::ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:id])
    app_pet = ApplicationPet.find_app_pet(params[:id], params[:pet_id])
    if params[:approved].present?
      app_pet.update!(pet_status: 1)
    else
      app_pet.update!(pet_status: 2)
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end 