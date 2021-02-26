class Api::V1::SessionsController < Api::ApiController
  def create
    response = Users::SessionService.call(session_params: session_params)

    return respond_with response.result, location: '', scope: response.result.refresh_token if response.success?

    render_unprocessable_entity_error(response.error)
  end

  private

  def session_params
    params.permit(:email, :password)
  end

end
