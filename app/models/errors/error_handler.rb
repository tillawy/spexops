### https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b
module Errors
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |e|
          Rails.logger.error(e.message)
          Rails.logger.error(e.backtrace)
          respond_to do |format|
            format.html {
              raise e if Rails.env.development?
            }
            format.json {
              respond(:standard_error, 500, e.message)
            }
          end
        end
        rescue_from Pundit::NotAuthorizedError, with: :not_authorized
        rescue_from ActiveRecord::RecordNotUnique, with: :duplicate
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        rescue_from Errors::NotAuthenticatedError, with: :not_authenticated
        rescue_from Errors::NotAcceptableError, with: :not_acceptable
        rescue_from OAuth2::Error, with: :with_oauth2_error
        rescue_from Dry::Struct::Error, with: :unprocessable
      end
    end

    private

    def with_oauth2_error(e)
      respond_to do |format|
        format.html {
          redirect_to oauth_failure
        }
        format.json {
          respond(e, 401, "not authenticated")
        }
      end
    end

    def custom_error(e)
      Rails.logger.error(e)
      respond(e.m, 403, "not authorized")
    end

    def not_authorized(e)
      Rails.logger.error(e)
      respond(e, 403, "not authorized")
    end

    def unprocessable(e)
      Rails.logger.error(e)
      respond(e, 422, "unprocessable")
    end

    def duplicate(e)
      Rails.logger.error(e)
      respond(e, 409, "duplicate")
    end

    def not_acceptable(e)
      Rails.logger.error(e.full_message)
      respond(e, 406, "not acceptable")
    end

    def record_not_found(e)
      Rails.logger.error(e)
      respond(e, 404, "not found")
    end

    def not_authenticated(e)
      Rails.logger.error(e)
      respond_to do |format|
        format.html {
          redirect_to "/"
        }
        format.json {
          respond(e, 401, "not authenticated")
        }
      end
    end

    def respond(error, status, message)
      json = Helpers::Render.json(error, status, message)
      render json: json, status: status
    end
  end
end
