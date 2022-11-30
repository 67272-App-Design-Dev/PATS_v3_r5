require 'helpers/deletions'
class MedicineCost < ApplicationRecord
  include Deletions

  # Relationships
  belongs_to :medicine

  # Scopes
  scope :chronological, -> { order('start_date') }
  scope :current,       -> { where("end_date IS NULL") }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  scope :for_medicine,  ->(medicine_id) { where(medicine_id: medicine_id) }

  # Validations
  validates_numericality_of :cost_per_unit, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date

  # Callback (to handle in sqlite what we would have done in a postrges trigger)
  before_create :set_end_date_of_old_cost

  before_destroy do 
    cannot_destroy_object() unless self.medicine.dosages.empty?
  end

  private
  def set_end_date_of_old_cost
    previous = MedicineCost.current.for_medicine(self.medicine_id).take
    previous.update_column(:end_date, self.start_date) unless previous.nil?
  end

end
