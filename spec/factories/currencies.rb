FactoryGirl.define do
  factory :currency do
    name "Afghani"
    sequence(:code) { |i| "CC#{i}"}
    country_id "af"
    weight "3.59144658850593"
    collector_value "7.820516121919"
    association :user, factory: :user
    association :country, factory: :country
  end

  factory :leu, class: Currency do
    name "Leu"
    code "ROL"
    country_id "ro"
    weight "0.265963278259138"
    collector_value "0.955296052405503"
    association :user, factory: :user
    association :country, factory: :country
  end
end