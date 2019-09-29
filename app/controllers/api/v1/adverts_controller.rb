# frozen_string_literal: true

class Api::V1::AdvertsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def show
    render json: Advert.find(params[:id])
  end

  def index
    adverts = Advert.order(:created_at).page(params[:page]).per(10)
    if params[:price].present?
      min = params[:price][:min] || 0
      max = params[:price][:max] || 10**10
      adverts = adverts.where(price: (min..max))
    end
    adverts = adverts.where(adverts.arel_table[:title].lower.matches("%#{params[:title].downcase}%")) if params[:title].present?
    adverts
    render json: adverts
  end

  def create
    advert = current_user.adverts.new(advert_params)
    if advert.save
      render json: advert, status: :created
    else
      render json: advert, status: :unprocessable_entity
    end
  end

  def update
    advert = current_user.adverts.find(params[:id])
    if advert.update(advert_params)
      render json: advert, status: :created
    else
      render json: advert, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.adverts.find(params[:id]).destroy!
    render status: :ok
  end

  private

  def advert_params
    params.permit(:price, :title, :description, :image)
  end
end
