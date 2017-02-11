class UsersController < ApplicationController
  layout 'authentication', except: :show

  before_action :unauthenticated_only, only: [:new, :create]
  before_action :authenticated_only, only: :show
  before_action :find_user, only: [:show, :edit, :update]

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

  def update
    redirect_to profile_user_path(@user) if @user.update!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar,
                                 :first_name, :last_name, :age, :location, :about)
  end

  def find_user
    @user = User.find(params[:id]).decorate
  end
end
