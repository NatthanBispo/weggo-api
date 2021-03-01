class Users::SessionService < BusinessProcess::Base
  needs :session_params

  steps :find_user,
        :verify_password

  def call
    process_steps
    @user
  end

  private

  def find_user
    @user = User.find_for_database_authentication(email: session_params[:email])
    fail([I18n.t('services.session_service.errors.user_not_found')]) unless @user.present?
  end

  def verify_password
    return if @user.valid_password?(session_params[:password])

    fail([I18n.t('services.session_service.errors.invalid_params')])
  end

end
