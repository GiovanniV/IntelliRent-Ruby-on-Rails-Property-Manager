class PropertiesController < ApplicationController
    before_action :authenticate_user!, :except => [:show]
	def new
	 @property = Property.new
	end

	def create
	 @property = Property.new(property_params)
	if @property.save
	  redirect_to root_path
	  else
		render new_property_path
	  end	
	end
	def edit
	@property = Property.find(params[:id])
	end
	
	def update
    @property = Property.find(params[:id])
 
    if @property.update(property_params)
      redirect_to root_path
    else
      render 'edit'
    end
   end
   def show
    @property = Property.find(params[:id])
   end
   
    def destroy
    @property = property.find(params[:id])
    @property.destroy
 
    redirect_to root_path
   end
	
	private 
	def property_params
    params.require(:property).permit(:title, :description)
  end
end
