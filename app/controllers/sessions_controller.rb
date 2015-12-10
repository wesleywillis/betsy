class SessionsController < ApplicationController
  # require login needs to be created in the ApplicationController to create flash message
  # skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
  # session_data is created in our form_for in sessions view page.
  end
end
