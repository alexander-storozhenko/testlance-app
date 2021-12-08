class ValidatorController < Devise::RegistrationsController
  before_action :authenticate_scope!

  def index
    render 'validator/test_template_validator'
  end
end
