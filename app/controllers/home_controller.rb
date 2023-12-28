class HomeController < ApplicationController
  include ActiveStorageOnDisk

  before_action :set_active_storage_url_options, only: [:index]

  def index
    @properties = Property.paginate(page: params[:page], per_page: 10)
    filter_properties if params[:filter].present?

    render
  end

  private
  
  def filter_properties
    # Reuse the same filter_properties method as in PropertiesController
    @properties = @properties.where('price <= ?', params[:max_price].to_i) if params[:max_price].present?
    @properties = @properties.where('bedrooms >= ?', params[:min_bedrooms].to_i) if params[:min_bedrooms].present?
    @properties = @properties.where('bathrooms >= ?', params[:min_bathrooms].to_i) if params[:min_bathrooms].present?
  end
end
