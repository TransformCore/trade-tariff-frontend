FactoryBot.define do
  factory :section do
    title    { Forgery(:basic).text }
    position { 1 }
  end

  factory :goods_nomenclature do
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { '0100000000' }
    validity_start_date { Date.today.ago(3.years) }
    validity_end_date   { nil }
  end

  factory :chapter do
    section { attributes_for(:section) }
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { '0100000000' }
    formatted_description { Forgery(:basic).text }
  end

  factory :heading do
    chapter { attributes_for(:chapter) }
    description { Forgery(:basic).text }
    formatted_description { Forgery(:basic).text }
    goods_nomenclature_item_id { '0101000000' }
  end

  factory :commodity do
    heading { attributes_for(:heading) }
    section { attributes_for(:section) }
    description { Forgery(:basic).text }
    formatted_description { Forgery(:basic).text }
    goods_nomenclature_item_id { '0101300000' }
    goods_nomenclature_sid { Forgery(:basic).number }
    parent_sid { Forgery(:basic).number }
    meursing_code { false }
  end

  factory :monetary_exchange_rate do
    child_monetary_unit_code { 'GBP' }
    exchange_rate { Random.rand.to_d.truncate(9) }
    operation_date { Date.today.at_beginning_of_month.ago(5.days).strftime('%Y-%m-%d') }
    validity_start_date { Date.today.at_beginning_of_month.strftime('%Y-%m-%d') }
  end

  factory :order_number do
    number { Forgery(:basic).number(exactly: 6).to_s }
  end

  factory :definition, class: 'OrderNumber::Definition' do
    quota_definition_sid { Forgery(:basic).number }
    initial_volume { '54000.0' }
    validity_start_date { '2021-01-01T00:00:00.000Z' }
    validity_end_date { '2021-12-31T00:00:00.000Z' }
    status { 'Open' }
    description { nil }
    balance { '54000.0' }
    measurement_unit { 'Kilogram (kg)' }
    monetary_unit { nil }
    measurement_unit_qualifier { nil }
    last_allocation_date { nil }
    suspension_period_start_date { nil }
    suspension_period_end_date { nil }
    blocking_period_start_date { nil }
    blocking_period_end_date { nil }
    order_number { attributes_for(:order_number) }
  end

  factory :measure do
    transient do
      measure_type_description { Forgery(:basic).text }
    end

    origin { %w[eu uk].sample }
    effective_start_date { Date.today.ago(3.years).to_s }
    effective_end_date { nil }

    measure_type do
      attributes_for(:measure_type, id: Forgery(:basic).text, description: measure_type_description).stringify_keys
    end

    trait :vat do
      measure_type do
        attributes_for(:measure_type, :vat, description: measure_type_description).stringify_keys
      end
    end

    trait :vat_excise do
      measure_type do
        attributes_for(:measure_type, :vat_excise, description: measure_type_description).stringify_keys
      end
    end

    trait :trade_remedies do
      measure_type do
        attributes_for(:measure_type, :trade_remedies, description: measure_type_description).stringify_keys
      end
    end

    trait :import_controls do
      measure_type do
        attributes_for(:measure_type, :import_controls, description: measure_type_description).stringify_keys
      end
    end

    trait :customs_duties do
      measure_type do
        attributes_for(:measure_type, :customs_duties, description: measure_type_description).stringify_keys
      end
    end

    trait :quotas do
      measure_type do
        attributes_for(:measure_type, :quotas, description: measure_type_description).stringify_keys
      end
    end

    trait :third_country do
      measure_type do
        attributes_for(:measure_type, :third_country, description: measure_type_description).stringify_keys
      end
      geographical_area { attributes_for(:geographical_area, :third_country).stringify_keys }
    end

    trait :specific_country do
      geographical_area { attributes_for(:geographical_area, :specific_country).stringify_keys }
    end

    trait :with_conditions do
      measure_conditions { [attributes_for(:measure_condition).stringify_keys] }
    end

    trait :with_additional_code do
      additional_code { attributes_for(:additional_code).stringify_keys }
    end

    trait :with_footnotes do
      footnotes { [attributes_for(:footnote).stringify_keys] }
    end

    trait :national do
      origin { 'uk' }
    end

    trait :eu do
      origin { 'eu' }
    end
  end

  factory :duty_expression do
    base { '80.50 EUR / Hectokilogram' }
    formatted_base { "80.50 EUR / <abbr title='Hectokilogram'>Hectokilogram</abbr>" }
    national_measurement_units { nil }
  end

  factory :measure_type do
    id { Forgery(:basic).text(exactly: 3) }
    description { Forgery(:basic).text }

    trait :vat do
      description { 'VAT' }
    end

    trait :vat_excise do
      id { '305' }
    end

    trait :import_controls do
      id { '277' }
    end

    trait :trade_remedies do
      id { '551' }
    end

    trait :customs_duties do
      id { '142' }
    end

    trait :quotas do
      id { '122' }
    end

    trait :third_country do
      id { '103' }
    end
  end

  factory :geographical_area do
    id { Forgery(:basic).text(exactly: 2).upcase }
    description { Forgery(:basic).text }

    trait :third_country do
      id { '1011' }
    end

    trait :specific_country do
      description { Forgery(:basic).text }
    end

    trait :with_children do
      children_geographical_areas { [attributes_for(:geograpical_area).stringify_keys] }
    end
  end

  factory :measure_condition do
    condition_code { Forgery(:basic).text(exactly: 1) }
    condition { Forgery(:basic).text }
    document_code { Forgery(:basic).text(exactly: 4) }
    requirement { Forgery(:basic).text }
    action { Forgery(:basic).text }
    duty_expression { Forgery(:basic).text }
  end

  factory :additional_code do
    code { Forgery(:basic).text }
    description { Forgery(:basic).text }
  end

  factory :footnote do
    code { Forgery(:basic).text }
    description { Forgery(:basic).text }
  end

  factory :tariff_update do
    update_type do
      %w[TariffSynchronizer::ChiefUpdate TariffSynchronizer::TaricUpdate].sample
    end
    state { 'A' }
    created_at { Time.now.to_s }
    updated_at { Time.now.to_s }
    filename { 'filename.txt' }

    trait :chief do
      update_type { 'TariffSynchronizer::ChiefUpdate' }
    end

    trait :taric do
      update_type { 'TariffSynchronizer::TaricUpdate' }
    end
  end
end
