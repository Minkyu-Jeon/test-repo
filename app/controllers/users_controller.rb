class UsersController < ApplicationController
  def create
    require_params! :email, :password

    result = Users::SignupUser.new(create_user_params).call

    render json: result
  end

  private

  def create_user_params
    params.permit(:email, :password)
  end
end
