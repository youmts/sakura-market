FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    price { 1 }

    association :product
    association :order
  end
end
