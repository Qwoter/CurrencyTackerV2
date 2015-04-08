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
    weight "3.59144658850593"
    collector_value "7.820516121919"
    association :user, factory: :user
    association :country, factory: :country
  end

  factory :a, class: Currency do
    name "A"
    code "A"
    country_id "a"
    weight "5"
    collector_value "25"
    association :user, factory: :user
    association :country, factory: :country
  end

  factory :b, class: Currency do
    name "B"
    code "B"
    country_id "b"
    weight "4"
    collector_value "50"
    association :user, factory: :user
    association :country, factory: :country
  end

  factory :c, class: Currency do
    name "C"
    code "C"
    country_id "c"
    weight "3"
    collector_value "10"
    association :user, factory: :user
    association :country, factory: :country
  end

  factory :d, class: Currency do
    name "D"
    code "D"
    country_id "d"
    weight "10"
    collector_value "110"
    association :user, factory: :user
    association :country, factory: :country
  end
end