module Errors
  class CustomError < StandardError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, message = nil)
      @error = error || I18n.t("error")
      @status = status || :unprocessable_entity
      @message = message || I18n.t("something_went_wrong")
    end

    def fetch_json
      Helpers::Render.json(error, message, status)
    end
  end
end
