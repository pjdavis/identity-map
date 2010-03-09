class Cache

  def initialize
    @objects = {}
  end

  def put(object)
    objects = @objects[object.class] ||= {}
    if objects[object.id]
      objects[object.id]
    else
      objects[object.id] = object
      object
    end
  end

end