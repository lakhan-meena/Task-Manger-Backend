module AuthenticationHandler
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  class TokenExpiredError < StandardError; end

  def authenticate!
    current_user

    unless @current_user
      render json: { error: "Unauthorized Access" }, status: :unauthorized
    end
  rescue TokenExpiredError
    render json: { error: "Access Token Expired" }, status: :unauthorized
  end

  def current_user
    @current_user ||= begin
      access_token = bearer_token

      decoded = JWT.decode(
        access_token,
        nil,
        false,
        { algorithm: "none" }
      )

      payload = decoded[0]

      raise TokenExpiredError if Time.current.to_i > payload["exp"]

      User.joins(:auth_token)
          .find_by(auth_tokens: { access_token: access_token })
    rescue JWT::DecodeError => e
      Rails.logger.error("Token Decode Error: #{e.message}")
      nil
    rescue TokenExpiredError
      raise
    rescue StandardError => e
      Rails.logger.error("Error in current_user: #{e.message}")
      nil
    end
  end

  def bearer_token
    header = request.headers["Authorization"]

    return unless header.present?

    pattern = /^Bearer /
    header.gsub(pattern, "") if header.match?(pattern)
  end
end