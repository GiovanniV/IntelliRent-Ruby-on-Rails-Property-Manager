class PropertyAttachmentsController < ApplicationController
 def create
     @property_attachments = PropertyAttachment.new(property_attachments_params)
     @property_attachments.save
   end
end