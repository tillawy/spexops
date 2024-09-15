module Versions
  class Version < Base
    include PaperTrail::VersionConcern
  end
end
