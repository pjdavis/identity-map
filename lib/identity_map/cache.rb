class Cache

  def initialize
    @objects = {}
  end

  def put(object)
    objects = @objects[object.class] ||= {}
    if objects[object.id]
      RAILS_DEFAULT_LOGGER.warn "Called From Cache #{objects[object.id].__id__}"
      objects[object.id]
    else
      RAILS_DEFAULT_LOGGER.warn "Not Found In Cache #{object.__id__}"
      objects[object.id] = object
      object
    end
  end

end