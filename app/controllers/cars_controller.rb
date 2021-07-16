class CarsController < ApplicationController
  def index
    filters = params.permit(:color, :model, :min_price, :max_price).to_h
    filter = Filter.new(Car.all, filters)
    cars = filter.call

    render json: { cars: cars.as_json, status: :ok }
  end

  def create
    car = Car.new(car_params)

    if car.save
      render json: { car: car, status: :ok }, status: :created
    else
      render json: { status: :error, errors: car.errors }, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    missing_car
  end

  def destroy
    car = Car.find_by(id: params[:id])

    if car
      car.destroy!

      render json: { status: :ok }
    else
      head :not_found
    end
  end

  private

  def car_params
    params.
      require(:car).
      permit(
        :color,
        :model,
        :price,
      )
  end

  def missing_car
    render(
      json: {
        status: :error,
        errors: {
          request: '`car` parameter is missing.',
        },
      },
      status: :unprocessable_entity,
    )
  end
end
