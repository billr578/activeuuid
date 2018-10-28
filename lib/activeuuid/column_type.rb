module ActiveUUID
  # A data type to be used with ActiveRecord.
  #
  # See docs for +::ActiveRecord::Attributes::ClassMethods#attribute+ for usage.
  # See docs for +::ActiveRecord::Type::Value+ for meaning of overriden methods.
  #
  # The +#type+ method is defined in a parent class, and returns +:binary+.
  class ColumnType < ::ActiveRecord::Type::Binary
    undef type

    # Converts UUID or its string representation into a binary value (see
    # super).
    def serialize(value)
      super(cast_to_uuid(value)&.raw)
    end

    # Converts strings into UUIDs on value assignment.
    def cast(value)
      super(cast_to_uuid(value))
    end

    # Converts binary values into UUIDs.
    def deserialize(value)
      cast_to_uuid(super(value))
    end

    private

    def cast_to_uuid(value)
      String === value ? UUIDTools::UUID.parse_string(value) : value
    end
  end
end
