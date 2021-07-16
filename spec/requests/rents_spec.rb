require 'rails_helper'

describe '/rents endpoint' do
  describe 'create' do
    it 'creates rent for car' do
      car = create(:car)
      _rent = create(
        :rent,
        car: car,
        start_at: 1.month.since,
        end_at: 1.month.since,
      )

      expect do
        post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.tomorrow } }
      end.to change(Rent, :count).by(1)
    end

    it 'return 201 status' do
      car = create(:car)

      post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.tomorrow } }

      expect(response).to have_http_status :created
    end

    context 'wrong range' do
      it 'does not create rent' do
        car = create(:car)

        expect do
          post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.yesterday } }
        end.not_to change(Rent, :count)
      end

      it 'returns 422 status' do
        car = create(:car)

        post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.yesterday } }

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'car already rented' do
      it 'does not create rent' do
        car = create(:car)
        _rent = create(
          :rent,
          car: car,
          start_at: Date.today,
          end_at: Date.today,
        )

        expect do
          post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.tomorrow } }
        end.not_to change(Rent, :count)
      end

      it 'returns 409 status' do
        car = create(:car)
        _rent = create(
          :rent,
          car: car,
          start_at: Date.today,
          end_at: Date.today,
        )

        post '/rents', params: { rent: { car_id: car.id, start_at: Date.today, end_at: Date.tomorrow } }

        expect(response).to have_http_status :conflict
      end
    end

    context 'non existent car' do
      it 'does not create rent' do
        post '/rents', params: { rent: { car_id: 1234, start_at: Date.today, end_at: Date.tomorrow } }

        expect(response).to have_http_status :not_found
      end

      it 'returns 404 status' do
        expect do
          post '/rents', params: { rent: { car_id: 1234, start_at: Date.today, end_at: Date.tomorrow } }
        end.not_to change(Rent, :count)
      end
    end
  end
end
