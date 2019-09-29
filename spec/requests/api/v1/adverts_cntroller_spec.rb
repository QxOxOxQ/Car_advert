# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AdvertsController, type: :request do
  let!(:user) { create(:user) }

  describe 'GET /api/adverts/' do
    let!(:advert) { create(:advert) }

    context 'when current user is owner' do
      before { sign_in advert.user }

      it 'returns advert' do
        get "/api/adverts/#{advert.id}.json"
        expect(json['title']).to eq(advert.title)
        expect(json['description']).to eq(advert.description)
        expect(json['price']).to eq(advert.price)
        expect(json['paths']['image']).not_to be_empty
        expect(json['paths']['self']).to eq "/api/adverts/#{advert.id}"
        expect(json['paths']['destroy']).to eq "/api/adverts/#{advert.id}"
        expect(json['paths']['update']).to eq "/api/adverts/#{advert.id}"
      end
    end

    context 'when current user is not owner' do
      before { sign_in user }

      it 'returns advert' do
        get "/api/adverts/#{advert.id}.json"
        expect(json['title']).to eq(advert.title)
        expect(json['description']).to eq(advert.description)
        expect(json['price']).to eq(advert.price)
        expect(json['paths']['image']).not_to be_empty
        expect(json['paths']['self']).to eq "/api/adverts/#{advert.id}"
        expect(json['paths']['destroy']).to be_nil
        expect(json['paths']['update']).to be_nil
      end
    end

    context 'when current user is not exist' do
      it 'returns advert' do
        get "/api/adverts/#{advert.id}.json"
        expect(json['title']).to eq(advert.title)
        expect(json['description']).to eq(advert.description)
        expect(json['price']).to eq(advert.price)
        expect(json['paths']['image']).not_to be_empty
        expect(json['paths']['self']).to eq "/api/adverts/#{advert.id}"
        expect(json['paths']['destroy']).to be_nil
        expect(json['paths']['update']).to be_nil
      end
    end
  end

  describe 'GET api/v1/adverts' do
    context 'without filtr' do
      let!(:adverts) { create_list(:advert, 11) }

      it 'returns list of advert' do
        get '/api/adverts.json'
        expect(json.size).to eq(10)
        json.each_with_index do |json_advert, index|
          aggregate_failures do
            expect(json_advert['id']).to eq(adverts[index].id)
            expect(json_advert['title']).to eq(adverts[index].title)
            expect(json_advert['description']).to eq(adverts[index].description)
            expect(json_advert['price']).to eq(adverts[index].price)
            expect(json_advert['paths']['image']).not_to be_empty
            expect(json_advert['paths']['self']).to eq "/api/adverts/#{adverts[index].id}"
            expect(json_advert['paths']['destroy']).to be_nil
            expect(json_advert['paths']['update']).to be_nil
          end
        end
      end

      context 'with filtr' do
        let!(:searching_advert) { create(:advert, title: 'FinD Me', price: 5) }
        let!(:searching_advert2) { create(:advert, title: 'FIND ME', price: 10) }
        let!(:searching_advert3) { create(:advert, title: 'XXXfind meXXX', price: 15) }

        it 'filtr by title returns matched adverts' do
          get '/api/adverts', params: { title: 'find me', format: :json }
          expect(json.size).to eq(3)
          expect(json[0]['id']).to eq(searching_advert.id)
          expect(json[1]['id']).to eq(searching_advert2.id)
          expect(json[2]['id']).to eq(searching_advert3.id)
        end

        it 'filtr by price returns matched adverts' do
          get '/api/adverts', params: { price: { min: 4.5, max: 14 }, format: :json }
          expect(json.size).to eq(2)
          expect(json[0]['id']).to eq(searching_advert.id)
          expect(json[1]['id']).to eq(searching_advert2.id)
        end

        it 'filtr by price and title returns matched adverts' do
          get '/api/adverts', params: { title: 'find me', price: { min: 4.5, max: 14 }, format: :json }
          expect(json.size).to eq(2)
          expect(json[0]['id']).to eq(searching_advert.id)
          expect(json[1]['id']).to eq(searching_advert2.id)
        end
      end
    end
  end
end
