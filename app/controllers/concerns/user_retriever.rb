module UserRetriever
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= AuthToken.verify(token) if token.present?
  end

  private

  def token
    @token ||= authorization_headers&.split(' ')&.last
  end

  def authorization_headers
    request.headers['Authorization']
  end
end
