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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
    
  def transaction
    @user = User.find(params[:user_id])
  end

  def plan_upgrade
    @user = User.find(params[:user_id])
    @user.upgrade.plan_id = Plan.last.id
    @user.upgrade.startDate = DateTime.now
    @user.upgrade.endDate = DateTime.now + 5.month
    @user.upgrade.duration = (@user.upgrade.startDate.month..@user.upgrade.endDate.month).count
    @user.upgrade.save
    @user.add_payment(payment_method = params[:user][:payment][:method],
                      holder_name = params[:user][:payment][:card_holder_name], 
                      card_number = params[:user][:payment][:card_number],
                      exp_year = params[:date][:year], exp_month = params[:date][:month],
                      cvc = params[:user][:payment][:cvc],
                      billing_address = params[:user][:payment][:billing_address]
                    )
    redirect_to upgrade_index_url
    flash[:alert] = "Plan ugrade successfully updated."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :role, :verified)
  end

  def update_user_params
    params.require(:user).permit(:user_name, :phone_number, :address, :role, :verified)
  end

  # def plan_upgrade_params
  #   params.require(:user).permit(:id, upgrade_attributes: [:user_id, :plan_id, :status])
  # 
  # end
end
