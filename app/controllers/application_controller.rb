class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  # before_action :authenticate_user!
  # （ログイン済みユーザーのみアクセスを許可する）
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end
  
  def production?
    Rails.env.production?
  end
end
