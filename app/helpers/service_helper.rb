module ServiceHelper
  def default_title
    t("title.default", service_name: service_name, service_description: service_description)
  end

  def goods_nomenclature_title(goods_nomenclature)
    t(
      "title.goods_nomenclature",
      goods_description: goods_nomenclature.to_s,
      service_name: service_name,
    )
  end

  def commodity_title(commodity)
    t(
      "title.commodity.#{service_choice}",
      commodity_description: commodity.to_s,
      commodity_code: commodity.code,
      service_name: service_name,
    )
  end

  def trade_tariff_heading
    t("trade_tariff_heading.#{service_choice}")
  end

  # TODO: Remove the uk-old case when we switch to the new UK version
  def switch_service_link
    case service_choice
    when "uk-old" then link_to(t("trade_tariff_heading.xi"), "/xi#{current_path}")
    when "uk" then link_to(t("trade_tariff_heading.xi"), "/xi#{current_path}")
    else
      link_to(t("trade_tariff_heading.uk-old"), current_path)
    end
  end

  def service_switch_banner(optional_classes: "govuk-!-margin-bottom-7")
    tag.div(class: "tariff-breadcrumbs js-tariff-breadcrumbs clt govuk-!-font-size-15 #{optional_classes}") do
      tag.nav do
        tag.p do
          banner_copy
        end
      end
    end
  end

private

  def service_name
    t("title.service_name.#{service_choice}")
  end

  def service_description
    t("title.service_description")
  end

  def service_choice
    TradeTariffFrontend::ServiceChooser.service_choice ||
      TradeTariffFrontend::ServiceChooser::SERVICE_DEFAULT
  end

  def banner_copy
    return t("service_banner.big.#{service_choice}", link: switch_service_link).html_safe if current_path == "/sections"

    t("service_banner.small", link: switch_service_link).html_safe
  end

  def current_path
    request.filtered_path.sub("/#{service_choice}", "")
  end
end
