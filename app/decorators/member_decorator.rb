class MemberDecorator < Draper::Decorator
  decorates :member
  delegate_all

  def gender
    source.gender == Member::GENDER[ :male ] ? I18n.t('pna.genders.male') : I18n.t('pna.genders.female')
  end

end
