# require needed files
require 'helpers/validations'
require 'helpers/deletions'
require 'helpers/activeable'

# create AppHelpers
module AppHelpers
  include AppHelpers::Validations
  include AppHelpers::Deletions
  include AppHelpers::Activeable::ClassMethods
  include AppHelpers::Activeable::InstanceMethods
end