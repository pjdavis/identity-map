module IdentityMap

  def self.included(base)
    base.extend(ClassMethods)
    class << base
      alias_method_chain :instantiate, :identity_map
      alias_method_chain :create, :identity_map
    end
  end

  module ClassMethods

  private

    def instantiate_with_identity_map(record)
      enlist_in_transaction(instantiate_without_identity_map(record))
    end

    def enlist_in_transaction(object)
      identity_map = Thread.current['identity_map']
      unless identity_map
        return object
      end
      identity_map.put(object)
    end

    def create_with_identity_map(options, &block)
      me = create_without_identity_map(options, &block)
      enlist_in_transaction(me)
    end

  end

end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send :include, IdentityMap
end
