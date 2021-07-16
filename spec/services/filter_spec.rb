require 'rails_helper'

describe Filter do
  describe '#filtered' do
    it 'returns correct records' do
      correct_cars = [
        create(:car, price: 30),
        create(:car, price: 50),
      ]
      _filtered_car_1 = create(:car, price: 10)
      _filtered_car_2 = create(:car, price: 100)

      filter = Filter.new(Car.all, min_price: 20, max_price: 60)

      expect(filter.call).to match_array(correct_cars)
    end

    it 'ignores blank values' do
      car = create(:car)

      filter = Filter.new(Car.all, model: '')

      expect(filter.call).to contain_exactly(car)
    end

    it 'ignores blank filters' do
      car = create(:car)

      filter = Filter.new(Car.all, {})

      expect(filter.call).to contain_exactly(car)
    end
  end
end
