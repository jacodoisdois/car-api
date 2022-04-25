class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by(" lower(email) = lower('#{user_params[:input]}') or lower(nickname) = lower('#{user_params[:input]}')")

    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        email: @user.email,
        nickname: @user.nickname
      }
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:input, :password)
  end
end
