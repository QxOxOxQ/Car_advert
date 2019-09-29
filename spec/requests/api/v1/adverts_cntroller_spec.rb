# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AdvertsController, type: :request do
  let!(:user) { create(:user) }
  let!(:advert) { create(:advert) }

  describe 'GET /api/adverts/' do
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
  end

  describe 'GET api/v1/adverts' do
  end
end
