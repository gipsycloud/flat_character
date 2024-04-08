class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    respond_with @user
  end

  def edit
  end

  def update
    @user.update(update_user_params)
    respond_with @user, notice: "Member was successfully updated."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :role, :verified)
  end

  def update_user_params
    params.require(:user).permit(:user_name, :phone_number, :address, :role, :verified, upgrade_attributes: [:user_id, :status])
  end
end
