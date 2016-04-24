class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pundit

  add_flash_types :success, :warning, :danger

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protect_from_forgery with: :exception

  private

    def not_authorized_message
      t("#{controller_name.sub(/s\z/, '')}.#{action_name}", scope: 'policies', default: :default)
    end

    def not_authorized
      flash[:danger] = not_authorized_message
      store_location
      redirect_to login_path
    end
end