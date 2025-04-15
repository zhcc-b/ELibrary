class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  protect_from_forgery with: :null_session


  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end


  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password)
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up successfully." },
        data: resource
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
