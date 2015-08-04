ActiveAdmin.register Property do
menu :priority => 2, :label => "Properties"
  permit_params :title, :description,:author,:price, :featured, :available_on,:image_file_name, :rent,:deposit, :lease, :pets, :utilities, :available_on, :parking, :squarefeet, :country, :state, :city, :zipcode, :address
 scope :all, :default => true
  scope :available do |properties|
    properties.where("available_on < ?", Date.today)
  end
  scope :drafts do |properties|
    properties.where("available_on > ?", Date.today)
  end
  scope :featured_properties do |properties|
    properties.where(:featured => true)
  end
  index :as => :grid do |property|
	div do
=begin	if property.image_file_name.blank?
	  a :href => admin_property_path(property) do
        image_tag("properties/no_image.jpg")
		end	
    else
    a :href => admin_property_path(property) do
        image_tag(property.image_file_name)
	end
	
    end	
=end	
	end
	a truncate(property.title), :href => admin_property_path(property)
  end

    show :title => :title
 	
	config.clear_action_items!
		action_item :only => :index do
		link_to "Add Property" , new_admin_property_path
	    end
		action_item :only => :show do
		link_to "Edit Property" , edit_admin_property_path, :confirm => "Are you sure"
	    end
		action_item :only => :show do
		link_to "Delete Property" , admin_property_path(property), :method => :delete, :confirm => "Are you sure"
	    end

  sidebar :property_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_property(resource).count }
      row("Dollar Value"){ number_to_currency LineItem.where(:property_id => resource.id).sum(:price) }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_property(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end
  
 #Edit Property form page starts
 
   form do |f|
     f.inputs "Property" do
	  f.input :title
	  f.input :rent
	  f.input :deposit
	  f.input :lease
	  f.input :pets, :label => 'Pets', :as => :select, :collection => [['Yes',1], ['No',0]], :include_blank => false
	  f.input :utilities, :label => 'Utilities', :as => :select, :collection => [['Yes',1], ['No',0]], :include_blank => false
	  f.input :description
	  f.input :available_on, :label => 'Apartment available', :as => :datepicker
	  f.input :parking
	  f.input :squarefeet
	  f.input :price
	  f.input :featured
	 end
	 f.inputs "Address Info" do
	 f.input :country, as: :select, collection: country_dropdown, :include_blank => false
	 f.input :state
	 f.input :city
	 f.input :zipcode
	 f.input :address
	 end
	 f.inputs "Add Images" do	 
	 f.file_field :image_file_name, multiple: false	 
	 end
=begin	 f.inputs "Gallery" do
	 f.has_many :property_attachments do |ff|
	   ff.input :image_file
	 end
	 end
=end	 
	 f.actions
   end
 #Edit Property form page ends
 
 #Property detail page starts
 show do 
 panel "Property details" do
  attributes_table_for property  do
  row :title
  row :rent
  row :deposit
  row :lease
  row :pets
  row :utilities
  row :description
  row :available_on
  row :parking
  row :squarefeet
  row :price
  row :featured
  end
 end
 panel "Address" do 
  attributes_table_for property do
  row :country
  row :state
  row :city
  row :zipcode
  row :address
  end
  end
  panel "Image" do
  attributes_table_for property do
  row :image_file_name do
  image_tag property.image_file_name.url
  end
  
  end
  end
  
  active_admin_comments
 end

 
 #Property detail page ends
 
   
=begin  
  sidebar "Active Admin Demo" do
    render('/admin/sidebar_links', :model => 'properties')
  end
=end
end
