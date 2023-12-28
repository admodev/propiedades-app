module ActiveStorageOnDisk
  extend ActiveSupport::Concern

  included do
    private
    def set_active_storage_url_options
      ActiveStorage::Current.url_options = { host: request.host_with_port, protocol: request.protocol }
    end
  end
end