require 'rails_helper'

describe AvailabilityFilter do
  it 'returns record without rent' do
    correct_car = create(:car)
    filtered_car = create(:car)

    _rent_1 = create(:rent, car: correct_car, start_at: 1.week.since, end_at: 1.week.since)
    _rent_3 = create(:rent, car: filtered_car, start_at: Date.today, end_at: Date.tomorrow)

    filter = AvailabilityFilter.new(Car.all, start_at: Date.today, end_at: Date.tomorrow)

    # binding.irb

    expect(filter.call).to contain_exactly(correct_car)
  end
end
