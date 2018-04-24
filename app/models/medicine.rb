class Medicine < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  
  # Relationships
  has_many :animal_medicines
  has_many :animals, :through => :animal_medicines
  has_many :medicine_costs
  has_many :dosages
  has_many :visits, :through => :dosages

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :depleted,     -> { where('stock_amount < ?', 100) }
  scope :vaccines,     -> { where(vaccine: true) }
  scope :nonvaccines,  -> { where(vaccine: false) }
  scope :for_animal,   ->(animal_id) { joins(:animal_medicines).where('animal_medicines.animal_id = ?', animal_id) }
  
  # Validations
  validates_presence_of :name
  validates_numericality_of :stock_amount, :only_integer => true, :greater_than_or_equal_to => 0
  
  # Other methods

  def is_vaccine?
    vaccine
  end
  
  def current_cost_per_unit
    curr_cost_of_medicine = self.medicine_costs.current
    return nil if curr_cost_of_medicine.empty?
    curr_cost_of_medicine.first.cost_per_unit
  end

  # Callbacks
  before_destroy do 
   check_if_ever_given_as_dosage
   if errors.present?
     @destroyable = false
     throw(:abort)
   else
     remove_associated_animal_medicines
     remove_associated_medicine_costs
   end
  end

  after_rollback :convert_to_inactive

  private
  def check_if_ever_given_as_dosage
    unless no_dosages?
      errors.add(:base, "Medicine cannot be deleted because previously used during visits, but its status has been set to inactive.")
    end
  end

  def no_dosages?
    self.dosages.empty?
  end

  def remove_associated_animal_medicines
    self.animal_medicines.each{ |am| am.destroy }
  end

  def remove_associated_medicine_costs
    self.medicine_costs.each{ |mc| mc.destroy }
  end

  # private

  def convert_to_inactive
    if !@destroyable.nil? && @destroyable == false
      self.update_attribute(:active, false)
    end
    @destroyable = nil
  end
end
