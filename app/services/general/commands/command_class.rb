module General
  module Commands
    module CommandClass
      def command_class(name:, action:)
        name = "Commands::#{name.capitalize}::#{action.capitalize}"
          raise "#{name} NOT DEFINED" unless Object.const_defined?(name)
        name.constantize
      end
    end
  end
end
