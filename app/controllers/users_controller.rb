class UsersController < ApplicationController
  layout 'authentication', except: :show

  before_action :unauthenticated_only, only: [:new, :create]
  before_action :authenticated_only, only: :show

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_user_path(@user), notice: t('.signe_up')
    else
      flash.now[:alert] = t('.incorrect_info')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
