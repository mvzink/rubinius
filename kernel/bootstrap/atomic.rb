# -*- encoding: us-ascii -*-

module Rubinius
  class AtomicReference
    def initialize(val=nil)
      set(val) if val
    end

    def marshal_dump
      get
    end

    def marshal_load(val)
      set(val)
    end

    def get
      Rubinius.primitive :atomic_get
      raise PrimitiveFailure, "get failed"
    end

    alias_method :value, :get

    def set(val)
      Rubinius.primitive :atomic_set
      raise PrimitiveFailure, "set failed"
    end

    alias_method :value=, :set

    def compare_and_set(old, new)
      Rubinius.primitive :atomic_compare_and_set
      raise PrimitiveFailure, "compare_and_set failed"
    end

    def get_and_set(new)
      while true
        val = get
        return val if compare_and_set(val, new)
      end
    end
  end
end
