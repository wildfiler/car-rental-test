class CarsController < ApplicationController
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
