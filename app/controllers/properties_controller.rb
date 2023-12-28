require 'csv'

class PropertiesController < ApplicationController
  include ActiveStorageOnDisk

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_active_storage_url_options, only: [:index, :show]
  before_action :load_commune_options, only: [:new, :edit]

  def index
    if current_user
      @properties = current_user.properties.page(params[:page])
      filter_properties if params[:filter].present?
    else
      @properties = Property.page(params[:page])
    end
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = current_user.properties.build(property_params)

    if @property.save
      redirect_to @property, notice: 'Propiedad creada exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Propiedad actualizada exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Propiedad eliminada exitosamente.'
  end

  private

  def load_commune_options
    @commune_options = CSV.read(Rails.root.join('lib/assets', 'comunas.csv').to_s, headers: true).map { |row| row['commune'] }
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:type, :price, :currency, :commune, :address, :area, :bedrooms, :bathrooms, :description, :photo)
  end

  def filter_properties
    @properties = @properties.where('price <= ?', params[:max_price].to_i) if params[:max_price].present?
    @properties = @properties.where('bedrooms >= ?', params[:min_bedrooms].to_i) if params[:min_bedrooms].present?
    @properties = @properties.where('bathrooms >= ?', params[:min_bathrooms].to_i) if params[:min_bathrooms].present?
  end
end
