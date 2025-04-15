class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  protect_from_forgery with: :null_session
  skip_before_action :verify_signed_out_user, only: [ :destroy ]  # 跳过验证已登出用户

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: {
      status: { code: 200, message: "Logged in successfully." },
      token: request.env["warden-jwt_auth.token"],
      user: {
        id: current_user.id,
        email: current_user.email,
        username: current_user.username
      }
    }
  end

  def destroy
    # 手动处理 JWT 令牌吊销
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      # JWT 吊销由 Devise JWT 中间件处理
      signed_out = sign_out(resource_name)
      render json: {
        status: 200,
        message: "Logged out successfully"
      }
    else
      render json: {
        status: 401,
        message: "No authorization token found"
      }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: "Logged in successfully." },
      token: request.env["warden-jwt_auth.token"],
      user: {
        id: resource.id,
        email: resource.email,
        username: resource.username
      }
    }
  end
end
