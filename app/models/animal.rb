class Animal < ApplicationRecord
  include AppHelpers::Deletions
  extend AppHelpers::Activeable::ClassMethods

  # Relationships
  has_many :pets
  has_many :animal_medicines
  has_many :medicines, through: :animal_medicines
  
  # Scopes
  scope :alphabetical, -> { order('name') }
  # scope :active,       -> { where(active: true) }
  # scope :inactive,     -> { where(active: false) }
   
  # Validations
  validates_presence_of :name

  # Callback - to prevent deletions
  before_destroy :cannot_destroy_object

end
