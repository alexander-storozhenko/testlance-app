class ValidatorController < Devise::RegistrationsController
  before_action :authenticate_scope!

  def index
    @tests_t = TestTemplate.where(confirm_status: :pending)

    render 'validator/test_template_validator'
  end
end
