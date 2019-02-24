class User < ApplicationRecord
  # settings is a JSON hash with keys such as "zip_code"
  # store_accessor allows us accessor methods on the keys within "settings"
  store_accessor :settings, :zip_code, :notify_of_frost_warning
end
