class CharacterDecorator < Draper::Decorator
  delegate_all

  def format_driving_license
    object.driving_license ? fa_icon_success : fa_icon_danger
  end

  def format_button
    if object.denied?
      edit_button
    elsif object.validated?
      more_button
    end
  end

  private

  def fa_icon_success
    h.fa_icon 'check', class: 'text-success'
  end

  def fa_icon_danger
    h.fa_icon 'times', class: 'text-danger'
  end

  def edit_button
    h.link_to h.t('.edit'), h.edit_user_character_path(object.user, object),
              class: 'btn btn-block btn-flat btn-warning'
  end

  def more_button
    h.link_to h.t('.more'), [object.user, object], class: 'btn btn-block btn-flat btn-primary'
  end
end
