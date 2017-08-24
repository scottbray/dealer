class CarsController < ApplicationController
  def index
    @cars = Car.all
  end
  
 def show
    @car = Car.find(params[:id])
 end
 
 def destroy
     car = Car.find(params[:id])
     car.destroy
     redirect_to cars_path
 end
 
 def new
    @car = Car.new
 end
 
 def create
     @car = Car.new(params[:car].permit(:vin, :make, :model, :year))
     if @car.save
         redirect_to @car
     else
         render 'new'
     end
 end
 
 def edit
    @car = Car.find(params[:id])
 end
 
 def update
 end
 
end