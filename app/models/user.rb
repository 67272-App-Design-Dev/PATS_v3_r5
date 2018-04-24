class User < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  # Use built-in rails support for password protection
  has_secure_password
    
  # Relationships
  # has_many :notes
  has_one :owner

  # Validations
  # make sure required fields are present
  validates_presence_of :first_name, :last_name 
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, :minimum => 4, message: "must be at least 4 characters long", :allow_blank => true
  validates_inclusion_of :role, in: %w( vet assistant owner ), message: "is not recognized in the system"
  
  # Other methods
  # -----------------------------  
  def proper_name
    first_name + " " + last_name
  end
  
  def name
    last_name + ", " + first_name
  end

  # for use in authorizing with CanCan
  ROLES = [['Vet', :vet],['Assistant', :assistant],['Owner', :owner]]

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end
  
  # login by username
  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

end
