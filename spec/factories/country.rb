FactoryGirl.define do
  factory :country do
    name "Afghanistan, Islamic State of"
    code "af"
    visited false
    association :user, factory: :user
  end
end
