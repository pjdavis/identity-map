module IdentityMap

  def self.included(base)
    base.extend(ClassMethods)
    class << base
      alias_method_chain :association_instance_set, :identity_map
    end
  end

  module ClassMethods

  private

  # Set the specified association instance.
  def association_instance_set_with_identity_map(name, association)
    identity_map = Thread.current['identity_map']
    unless identity_map
      association_instance_set_without_identity_map("@#{name}", association)
    else
      association_instance_set_without_identity_map("@#{name}", identity_map.put(association))
    end
  end


  end

end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Associations.send :include, IdentityMap
end
