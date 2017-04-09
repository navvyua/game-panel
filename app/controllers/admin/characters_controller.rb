class Admin::CharactersController < AdminController
  before_action :current_resource, only: :update

  def index
    @characters = Character.validating.decorate
  end

  def update
    @character.update!(character_params)
    send_validating_email
    process_action_cable
  end

  private

  def character_params
    params.require(:character).permit(:status, :deny_reason)
  end

  def current_resource
    @character = Character.find(params[:id])
  end

  def send_validating_email
    UserMailer.character_validating_email(@character.user, @character.decorate).deliver_now
  end

  def process_action_cable
    RemoveCharacterJob.perform_later @character
  end
end
