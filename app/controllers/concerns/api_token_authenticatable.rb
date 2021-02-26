module ApiTokenAuthenticatable
  extend ActiveSupport::Concern
  include ApiCommonResponses

  def authenticate_user_from_token!
    user, request_token = find_authenticable_by_headers(User)

    sign_in_matching_resource(user, request_token)
  end

  def build_headers_if_needed!
    return unless current_user.present?

    current_user.refresh_token.map { |key, value| response.headers[key.to_s] = value.to_s }
  end

  def current_user
    @resource
  end

  private

  def sign_in_matching_resource(resource, request_token)
    if resource.present? && resource.token_match?(request_token)
      sign_in resource, store: false
      @resource ||= resource
    else
      render_unauthorized_error
    end
  end

  def find_authenticable_by_headers(model)
    request_email = request.headers["HTTP_#{model.name.upcase}_EMAIL"].presence
    request_token = request.headers["HTTP_#{model.name.upcase}_TOKEN"].presence

    resource = request_email && model.find_by(email: request_email)
    return resource, request_token
  end

end
