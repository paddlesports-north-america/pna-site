class MemberDecorator < Draper::Decorator
  decorates :member
  delegate_all

  def gender
    source.gender == Member::GENDER[ :male ] ? I18n.t('pna.genders.male') : I18n.t('pna.genders.female')
  end

  def expiration_date
    unless source.memberships.empty?
      source.memberships.last.expiration_date
    else
      I18n.t('pna.non_member')
    end
  end

end
