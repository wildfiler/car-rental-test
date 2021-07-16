require 'rails_helper'

describe Car do
  it 'has working factory' do
    car = create(:car)

    expect(car).to be_valid
  end

  it 'has model' do
    car = build(:car, model: '')

    expect(car).to be_invalid

    car.model = 'XC90'

    expect(car).to be_valid
  end

  it 'has positive price' do
    car = build(:car, price: 0)

    expect(car).to be_invalid

    car.price = 1

    expect(car).to be_valid
  end

  it 'has color from list' do
    car = build(:car, color: 'pinguin black')

    expect(car).to be_invalid

    car.color = Car::COLORS.first

    expect(car).to be_valid
  end
end
