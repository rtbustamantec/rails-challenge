class VehiclesController < ApplicationController
  before_action :not_authorized

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicles_params)
    @vehicle.user = current_user
    if @vehicle.save
      redirect_to profile_path
    else
      render 'new'
    end
  end

  def edit
    @vehicle = current_user.vehicles.find(params[:id])
  end


  def update
    @vehicle = current_user.vehicles.find(params[:id])
    if @vehicle.update_attributes(vehicles_params)
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  def destroy
    @vehicle = current_user.vehicles.find(params[:id])
    @vehicle.destroy
    redirect_to profile_path
  end

  private

    def vehicles_params
      params.require(:vehicle).permit(:year, :make, :model, :license_plate, :photo)
    end
end
