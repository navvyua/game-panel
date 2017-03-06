class Admin::CharactersController < AdminController
  before_action :current_resource, only: :update

  def index
    @characters = Character.validating.decorate
  end

  def update
    @character.update!(character_params)
    redirect_to admin_characters_path, notice: t('.character_validated')
  end

  private

  def character_params
    params.require(:character).permit(:status, :deny_reason)
  end

  def current_resource
    @character = Character.find(params[:id])
  end
end
