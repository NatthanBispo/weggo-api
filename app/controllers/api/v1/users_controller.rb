class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_user_from_token!, except: [:create]

  def create
    user = User.new(user_params)
    if user.save
      sign_in user, store: false
      respond_with user, location: '', scope: user.refresh_token
    else
      render_unprocessable_entity_error(user.errors.full_messages)
    end
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      render json: current_user, serializer: UserSerializer, scope: current_user.refresh_token
    else
      render_unprocessable_entity_error(current_user.errors.full_messages)
    end
  end

  def show
    headers = current_user.refresh_token
    respond_with current_user, location: '', scope: headers
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

end
