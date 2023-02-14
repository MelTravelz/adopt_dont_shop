class Admin::ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:id])
    application.update(status: params[:status].to_i)
    redirect_to "/admin/applications/#{application.id}"
  end

end 