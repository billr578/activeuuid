require "activeuuid/version"
require "activeuuid/patches"
require "activeuuid/uuid"
require "activeuuid/column_type"
require "activeuuid/railtie" if defined?(Rails::Railtie)
require "pp"

module ActiveUUID
end

ActiveUUID::Patches.apply!
