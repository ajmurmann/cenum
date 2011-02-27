class Object
  def enum(*names)
    klass = Class.new
    names.map(&:to_s).each_with_index do |name, index|
      klass.const_set(name.capitalize, index)
      klass.send(:define_method, "#{name}?", lambda { @value == klass.const_get(name.to_s.capitalize) })
      klass.send(:define_method, "#{name}!", lambda { @value = klass.const_get(name.to_s.capitalize) })
    end
    klass.send(:define_method, :initialize, lambda { |name| @value = klass.const_get(name.to_s.capitalize) })
    klass.send(:define_method, :==, lambda { |other| @value == (other.respond_to?(:__value__) ? other.__value__ : other) })
    klass.send(:define_method, :__value__, lambda { @value })
    return klass
  end
end
