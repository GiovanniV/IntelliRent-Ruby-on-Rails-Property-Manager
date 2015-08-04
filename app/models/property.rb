class Property < ActiveRecord::Base
	validates :title, presence: true,
                    length: { minimum: 5 }
	after_initialize :set_available_on
	mount_uploader :image_file_name, PropertyImageUploader
	def set_available_on
	  self.available_on ||= DateTime.now.to_date
	end
	def property_params
      params.require(:property).permit()
    end
	
end
