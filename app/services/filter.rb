class Filter
  def initialize(scope, filters)
    @scope = scope
    @filters = filters
  end

  def call
    return @scope if @filters.blank?

    @filters.inject(@scope) do |scope, (filter, value)|
      next scope if value.blank?

      if respond_to?(filter)
        send(filter, scope, value)
      else
        scope.where(filter => value)
      end
    end
  end

  def min_price(scope, value)
    scope.where('price >= ?', value)
  end

  def max_price(scope, value)
    scope.where('price <= ?', value)
  end

  def start_at(scope, value)
    scope.where('start_at >= ?', value)
  end

  def end_at(scope, value)
    scope.where('end_at <= ?', value)
  end
end
