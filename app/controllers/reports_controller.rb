class ReportsController < ApplicationController
  before_action :current_report_user
  before_action :current_report, only: %i(show destroy)

  def index
    created_reports
    received_reports
  end

  def new
    @report = @user.reports.new
  end

  def create
    @report = @user.reports.new report_params
    character = Character.autocomplete_find(params[:character_name]).take
    @report.character = character

    if @report.save && character
      redirect_to [@user, @report], notice: t('.report_created')
    else
      flash.now[:alert] = t('.incorrect_character')
      render :new
    end
  end

  def destroy
    @report.destroy!
    redirect_to user_reports_path @user
  end

  def autocomplete_character_last_name
    term = params[:term]

    characters = Character.autocomplete_find(term)

    render json: characters.map { |character| character_hash(character) }
  end

  private

  def received_reports
    @received_reports = @user.received_reports.includes(:user).decorate
  end

  def created_reports
    @created_reports = @user.reports.includes(:user).decorate
  end

  def character_hash(character)
    {
      label: character.full_name,
      value: character.full_name
    }
  end

  def report_params
    params.require(:report).permit permitted_params
  end

  def permitted_params
    [
      :description,
      :character_name,
      { images: [] }
    ]
  end

  def current_report
    @report = @user.reports.find(params[:id]).decorate
  end

  def current_report_user
    @user = User.find params[:user_id]
  end
end
