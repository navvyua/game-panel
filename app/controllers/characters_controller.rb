class CharactersController < ApplicationController
  before_action :current_resource_owner
  before_action :current_resource, only: %i(show edit update)
  before_action :only_validated_character, only: :show
  before_action :only_denied_character, only: %i(edit update)

  def index
    @characters = @user.characters.includes(:user).decorate
  end

  def new
    @character = @user.characters.new
  end

  def create
    @character = @user.characters.new(character_params)
    if @character.save
      redirect_to user_characters_path(@user), notice: t('.character_created')
    else
      flash.now[:alert] = t('.incorrect_info')
      render :new
    end
  end

  def update
    if @character.update(character_params)
      redirect_to user_characters_path(@user), notice: t('.application_edited')
    else
      flash.now[:alert] = t('.incorrect_info')
      render :edit
    end
  end

  private

  def current_resource_owner
    @user = User.find(params[:user_id])
  end

  def current_resource
    @character = @user.characters.find(params[:id]).decorate
  end

  def character_params
    params.require(:character).permit(:first_name, :last_name, :age, :biography, :driving_license, :status,
                                      :deny_reason)
  end

  def only_validated_character
    redirect_back(fallback_location: root_path) unless @character.validated?
  end

  def only_denied_character
    redirect_back(fallback_location: root_path) unless @character.denied?
  end
end
