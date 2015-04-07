FactoryGirl.define do
  factory :currency do
    name "Afghani"
    code "AFA"
    country_id "af"
    weight "3.59144658850593"
    collector_value "7.820516121919"
    association :user, factory: :user
  end
end