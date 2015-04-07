FactoryGirl.define do
  factory :country do
    name "Afghanistan, Islamic State of"
    sequence(:code) { |i| "aa#{i}"}
    visited false
    association :user, factory: :user
  end

  factory :afghanistan, class: Country do
    name "Afghanistan, Islamic State of"
    code "afg"
    visited false
    association :user, factory: :user
  end
end
