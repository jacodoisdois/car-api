# User Controller
class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]
  before_action :check_login, only: %i[index update destroy show]

  include Paginable

  def index
    @users = User.page(current_page)
                 .per(per_page)
                 .search(params)

    options = get_links_serializer_options('api_v1_users_path', @users)

    render json: UserSerializer.new(@users, options).serializable_hash
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :email, :nickname, :password, :name)
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
