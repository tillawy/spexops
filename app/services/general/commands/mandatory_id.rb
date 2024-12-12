module General
  module Commands
    class MandatoryId < Dry::Struct
      include Dry.Types()
      attribute :id, Strict::String.optional.constrained(format: Uuid.regex)
    end
  end
end
