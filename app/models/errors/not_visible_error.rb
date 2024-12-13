module Errors
  class NotVisibleError < CustomError
    def initialize
      super(:you_cant_see_me, 422, "You cant see me")
    end
  end
end
