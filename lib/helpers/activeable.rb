module AppHelpers
  module Activeable
    module ClassMethods
      def active
        where(active: true)
      end
      
      def inactive
        where.not(active: true)
      end    
    end

    module InstanceMethods
      def make_active
        self.active = true
        self.save!
      end
      
      def make_inactive
        self.active = false
        self.save!
      end
    end
  end
end
