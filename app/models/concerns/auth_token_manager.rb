module AuthTokenManager
  extend ActiveSupport::Concern

  # Generate unique tokens
  def generate_auth_token
    access_token_payload = {
      data: "#{DateTime.now.to_i}#{self.id}",
      exp: 10.day.from_now.to_i,
      model_type: self.class.name
    }
    refresh_token_payload = {
      data: "#{SecureRandom.hex(10)}#{self.id}",
      exp: 20.day.from_now.to_i,
      model_type: self.class.name
    }

    # Encode tokens
    access_token = JWT.encode(access_token_payload, nil, 'none')
    refresh_token = JWT.encode(refresh_token_payload, nil, 'none')

    # Save/replace token and return the AuthToken record (not save's boolean)
    auth_token = self.auth_token || build_auth_token
    auth_token.update!(
      access_token: access_token,
      refresh_token: refresh_token
    )
    auth_token
  end

end