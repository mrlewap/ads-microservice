begin
  require_relative '.env.rb'
rescue LoadError
end

require 'sequel/core'

# Delete ADS_DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  ADS_DATABASE_URL may contain passwords.
DB = Sequel.connect(ENV.delete('ADS_DATABASE_URL') || ENV.delete('DATABASE_URL'))
