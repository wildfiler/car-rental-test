class RentsController < ApplicationController
  def create
    car = Car.find(rent_params[:car_id])

    rent = Rent.new(rent_params)

    if Filter.new(car.rents, rent_params.slice(:start_at, :end_at).to_h).call.exists?
      render json: { status: :error, errors: { request: 'car already rented' } }, status: :conflict
      return
    end

    if rent.save
      render json: { car: rent, status: :ok }, status: :created
    else
      render json: { status: :error, errors: rent.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { status: :error, errors: { request: 'car is not found' } }, status: :not_found
  end

  def rent_params
    @rent_params ||= params.
      require(:rent).
      permit(
        :car_id,
        :start_at,
        :end_at,
      )
  end
end
