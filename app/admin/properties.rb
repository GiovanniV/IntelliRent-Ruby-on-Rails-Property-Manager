ActiveAdmin.register Property do
menu :priority => 2, :label => "Properties"
  permit_params :title, :description,:author,:price, :featured, :available_on,:image_file_name
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
	if property.image_file_name.blank?
	  a :href => admin_property_path(property) do
        image_tag("properties/no_image.jpg")
		end	
    else
	   a :href => admin_property_path(property) do
        image_tag("properties/" + property.image_file_name)
		end	
    end	
	end
	a truncate(property.title), :href => admin_property_path(property)
  end

    show :title => :title
 	
	config.clear_action_items!
		action_item :only => :index do
		link_to "Add Property" , new_admin_property_path
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
=begin 
  sidebar "Active Admin Demo" do
    render('/admin/sidebar_links', :model => 'properties')
  end
=end
end
