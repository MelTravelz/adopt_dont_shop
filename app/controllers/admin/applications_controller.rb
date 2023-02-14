class Admin::ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:id])
    app_pet = ApplicaitonPet.find_app_pet(params[:id], params[:pet_id])
    
    if param[:approved].present?
      app_pet.update!(pet_status: 1)

    else
      app_pet.update!(pet_status: 2)
    end

    # application.update(status: params[:status].to_i)
    redirect_to "/admin/applications/#{application.id}"
  end

end 