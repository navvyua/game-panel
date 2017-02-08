module CharacterHelper
  def format_driving_license(character)
    character.driving_license ? fa_icon_success : fa_icon_danger
  end

  def format_money(value)
    number_to_currency(value, delimiter: ' ', precision: 0)
  end

  def validating_characters_count
    Character.validating.count
  end

  def character_button(character)
    if character.denied?
      edit_button(character)
    elsif character.validated?
      more_button(character)
    end
  end

  private

  def fa_icon_success
    fa_icon('check', class: 'text-success')
  end

  def fa_icon_danger
    fa_icon('times', class: 'text-danger')
  end

  def edit_button(character)
    link_to t('.edit'), edit_user_character_path(character.user, character),
            class: 'btn btn-block btn-flat btn-warning'
  end

  def more_button(character)
    link_to t('.more'), [character.user, character], class: 'btn btn-block btn-flat btn-primary'
  end
end
