FactoryGirl.define do
  factory :card do
    original_text "apple"
    translated_text "яблоко"
    user
    block

  end
end
