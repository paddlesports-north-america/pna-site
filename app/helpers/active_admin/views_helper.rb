module ActiveAdmin::ViewsHelper

  def t(key)
    I18n.t("pna.#{key}")
  end

end
