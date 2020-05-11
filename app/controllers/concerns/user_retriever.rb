module UserRetriever
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= AuthToken.verify(token) if token.present?
  end

  private

  def token
    @token ||= "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.BtR_0Mkfx6z6hzV8Fjzou21sBqUUINQr7GtVs619q6M"
  end

  def authorization_headers
    request.headers['Authorization']
  end
end
