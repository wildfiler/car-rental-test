class AvailabilityFilter
  def initialize(scope, filters)
    @scope = scope
    @filters = filters
  end

  def call
    return @scope if @filters.blank?

    @scope.where(rents_not_exists)
  end

  private

  def rents_not_exists
    rents.where(car_id.eq(rent_car_id)).exists.not
  end

  def rents
    Filter.new(Rent.all, @filters).call.arel
  end

  def car_id
    Car.arel_table[:id]
  end

  def rent_car_id
    Rent.arel_table[:car_id]
  end
end
