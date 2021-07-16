require 'rails_helper'

describe Rent do
  it 'has correct date range' do
    rent = build(:rent, start_at: Date.today, end_at: Date.yesterday)

    expect(rent).to be_invalid

    rent.end_at = Date.today

    expect(rent).to be_valid

    rent.end_at = Date.tomorrow

    expect(rent).to be_valid
  end
end
