module AuthHelper
  def http_login
    user = 'admin'
    password = 'password'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end
end
