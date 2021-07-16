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

  describe 'delete'
  describe 'index'
end
