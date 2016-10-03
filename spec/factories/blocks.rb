FactoryGirl.define do
  factory :block do
    title "First"
    user

    factory :block_with_one_card do
      after(:create) do |block|
        create(:card, user: block.user, block: block)
      end
    end
  end
end
