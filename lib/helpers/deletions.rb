module AppHelpers
  module Deletions
    # set up accessor methods for destroyable
    attr_accessor :destroyable

    # Multiple models do not allow for deletions, so we can 
    # create a simple method here for callbacks to use as needed
    def cannot_destroy_object
      self.destroyable = false
      msg = "This #{self.class.to_s.downcase} cannot be deleted at this time. If this is a mistake, please alert the administrator."
      errors.add(:base, msg)
      throw(:abort) if errors.present?
      # self.make_inactive if self.respond_to?(:active)
      # if respond_to? :active, why not make_inactive as well?            (hint: transactions)
    end
  end
end