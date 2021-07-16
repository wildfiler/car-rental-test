FactoryBot.define do
  factory :car do
    model { 'Mustang' }
    color { 'black' }
    price { 1000 }
  end

  factory :rent do
    car
    start_at { Date.today }
    end_at { Date.today }
  end
end
