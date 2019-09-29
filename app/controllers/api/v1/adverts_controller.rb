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

  def create; end

  def update; end

  def destroy; end

  private

  def advert_params; end
end
