class Api::ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user_from_token!

  respond_to :json

  ##
  # User Authentication
  # Authenticates the user with OAuth2 Resource Owner Password Credentials
  def authenticate_user_from_token!
    # ブラウザでログイン済の場合はスルー
    return if user_signed_in?

    authentication_token = request.headers['Authorization']

    if authentication_token
      authenticate_with_auth_token authentication_token
    else
      authenticate_error
    end
  end

  private

  def authenticate_with_auth_token authentication_token
    if user = User.find_by(authentication_token: authentication_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end
end