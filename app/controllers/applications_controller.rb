class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:find_pet].present?
      @find_pet = Pet.find_pet(params[:find_pet])
    else
      @find_pet = []
    end
  end

  def new
  end

  def create
    @application = Application.new(app_params)
    if @application.valid?
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:message] = @application.errors.full_messages[0]
      render :new
    end
  end

  # def update
  #   @application = Application.find(params[:id])
  #   require 'pry'; binding.pry
  #   if params[:sort] == 'add_pet'
  #     @applicaton.update(app_params)
  #     redirect_to "/applications/#{@application.id}"
  #   end 
  # end


  private
  
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end