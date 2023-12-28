class PropertiesController < ApplicationController
  include ActiveStorageOnDisk

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_active_storage_url_options, only: [:index, :show]

  def index
    if current_user
      @properties = current_user.properties.page(params[:page])
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

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:type, :price, :currency, :commune, :address, :area, :bedrooms, :bathrooms, :description, :photo)
  end
end
