FactoryBot.define do
  factory :order_item do
    order { "" }
    product { "" }
    quantity { 1 }
    price { 1 }
  end
end
