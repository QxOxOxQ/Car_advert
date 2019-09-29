# frozen_string_literal: true

class Api::V1::AdvertsController < ApplicationController
  def show
    render json: Advert.find(params[:id])
  end

  def index; end

  def create; end

  def update; end

  def destroy; end

  private

  def advert_params; end
end
