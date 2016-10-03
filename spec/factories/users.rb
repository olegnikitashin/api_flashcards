FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "foobar"


    factory :user_with_one_block_and_one_card  do
      after(:create) do |user|
        create(:block_with_one_card, user: user)
      end
    end
  end
end
