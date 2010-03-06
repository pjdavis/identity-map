module IdentityMap

  def self.included(base)
    base.before_dispatch :build_cache
    base.after_dispatch :remove_cache
  end

  def build_cache
    Thread.current['identity_map'] ||= Cache.new
  end

  def remove_cache
    Thread.current['identity_map'] = nil
  end

end
if Object.const_defined?("ActionController")
  ActionController::Dispatcher.send :include, IdentityMap
  RAILS_DEFAULT_LOGGER.warn "CACHING OBJECTS"
end