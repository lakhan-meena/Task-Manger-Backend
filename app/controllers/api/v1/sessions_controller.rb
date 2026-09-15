class Api::V1::SessionsController < Api::ApiController
  skip_before_action :authenticate!, only: :sign_in

  def sign_in
    user = User.find_by(email: params[:email]&.downcase)

    unless user&.authenticate(params[:password])
      return render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end

    auth_token = user.generate_auth_token

    set_token(
      auth_token.access_token,
      auth_token.refresh_token
    )

    render json: {
      message: "User successfully logged in",
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      }
    }, status: :ok
  end

  def sign_out
    if @current_user&.auth_token
      @current_user.auth_token.destroy
    end

    render json: {
      message: "User successfully logged out"
    }, status: :ok
  end

  private

  def set_token(access_token, refresh_token)
    response.set_header("Authorization", access_token)
    response.set_header("Refresh-Token", refresh_token)
  end
end