class HomeController < ApplicationController
  include ActiveStorageOnDisk

  before_action :set_active_storage_url_options, only: [:index]

  def index
    @properties = Property.paginate(page: params[:page], per_page: 10)

    render
  end
end
