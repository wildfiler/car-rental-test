require 'rails_helper'

describe '/cars endpoints' do
  describe 'create' do
    context 'valid attributes' do
      it 'creates car record' do
        car_attributes = attributes_for(:car)

        expect do
          post '/cars', params: { car: car_attributes }
        end.to change(Car, :count).by(1)
      end

      it 'returns 201 status' do
        car_attributes = attributes_for(:car)

        post '/cars', params: { car: car_attributes }

        expect(response).to have_http_status :created
      end

      it 'returns created car in the body' do
        car_attributes = attributes_for(:car)

        post '/cars', params: { car: car_attributes }

        car = Car.last

        expect(car).to be_present
        expect(response.body).to eq({ car: car, status: :ok }.to_json)
      end
    end

    context 'invalid attributes' do
      it 'does not create record' do
        car_attributes = attributes_for(:car, model: '')

        expect do
          post '/cars', params: { car: car_attributes }
        end.not_to change(Car, :count)
      end

      it 'returns 422 status' do
        car_attributes = attributes_for(:car, model: '')

        post '/cars', params: { car: car_attributes }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns errors in the body' do
        car_attributes = attributes_for(:car, model: '')

        post '/cars', params: { car: car_attributes }

        expect(response.body).to be_present
      end
    end

    context 'missing params' do
      it 'returns 422 status' do
        post '/cars'

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'delete' do
    context 'existing id' do
      it 'destroys record' do
        car = create(:car)

        expect do
          delete "/cars/#{car.id}"
        end.to change(Car, :count).by(-1)
      end

      it 'returns 200 status' do
        car = create(:car)

        delete "/cars/#{car.id}"

        expect(response).to have_http_status :ok
      end
    end

    context 'id not found' do
      it 'does not destroy any records' do
        car = create(:car)

        expect do
          delete '/cars/-1'
        end.not_to change(Car, :count)
      end

      it 'returns 404 status' do
        delete '/cars/-1'

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'index' do
    it 'returns 200 status' do
      get '/cars'

      expect(response).to have_http_status :ok
    end

    it 'returns all cars' do
      cars = create_list(:car, 2)

      get '/cars'

      parsed_body = response.parsed_body

      expect(parsed_body).to include('cars')
      expect(parsed_body['cars'].length).to eq cars.length
    end

    it 'returns correct json for car' do
      car = create(:car)

      get '/cars'

      parsed_body = response.parsed_body

      expect(parsed_body).to include('cars')

      returned_car = parsed_body['cars'].first

      expect(returned_car).to eq(car.as_json)
    end

    context 'filters' do
      context 'by color' do
        it 'returns correct records' do
          correct_cars = create_list(:car, 2, color: 'black')
          _filtered_car = create(:car, color: 'blue')

          get '/cars', params: { color: 'black' }

          parsed_body = response.parsed_body
          cars = parsed_body['cars']
          expect(cars.length).to eq(2)
          ids = cars.map { |car| car['id'] }
          expect(ids).to match_array(correct_cars.map(&:id))
        end
      end

      context 'by model' do
        it 'returns correct records' do
          correct_cars = create_list(:car, 2, model: 'Tesla')
          _filtered_car = create(:car, model: 'BMW')

          get '/cars', params: { model: 'Tesla' }

          expect_correct_cars_in(response, correct_cars)
        end
      end

      context 'by min price' do
        it 'returns correct records' do
          correct_cars = create_list(:car, 2, price: 100)
          _filtered_car = create(:car, price: 10)

          get '/cars', params: { min_price: 50 }


          expect_correct_cars_in(response, correct_cars)
        end
      end

      context 'by max price' do
        it 'returns correct records' do
          correct_cars = create_list(:car, 2, price: 10)
          _filtered_car = create(:car, price: 100)

          get '/cars', params: { max_price: 50 }

          expect_correct_cars_in(response, correct_cars)
        end
      end

      context 'by price range' do
        it 'returns correct records' do
          correct_cars = [
            create(:car, price: 30),
            create(:car, price: 50),
          ]
          _filtered_car_1 = create(:car, price: 10)
          _filtered_car_2 = create(:car, price: 100)

          get '/cars', params: { min_price: 20, max_price: 60 }

          expect_correct_cars_in(response, correct_cars)
        end
      end

      context 'multiple filters' do
        it 'returns correct records' do
          correct_cars = create_list(:car, 2, model: 'Tesla', color: 'black')
          _filtered_car_1 = create(:car, model: 'Tesla', color: 'blue')
          _filtered_car_2 = create(:car, model: 'BMW', color: 'black')

          get '/cars', params: { color: 'black', model: 'Tesla' }

          expect_correct_cars_in(response, correct_cars)
        end
      end
    end
  end

  def expect_correct_cars_in(response, correct_cars)
    parsed_body = response.parsed_body
    cars = parsed_body['cars']
    expect(cars.length).to eq(correct_cars.length)
    ids = cars.map { |car| car['id'] }
    expect(ids).to match_array(correct_cars.map(&:id))
  end
end
