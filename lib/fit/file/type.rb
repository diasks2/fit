module Fit
  class File
    class Type

      @@types = {}

      def self.get_type(name)
        return @@types[name] if @@types.has_key? name
        type = Types.get_type_definition name
        @@types[name] = type ? new(type) : nil
      end

      def initialize(type)
        @type = type
      end

      def value(val)
        res = @type[:values]
        res ? res[val] : nil
      end
    end
  end
end
