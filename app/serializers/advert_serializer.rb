# frozen_string_literal: true

class AdvertSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :price, :paths

  def paths
    output = { self: path('show'),
               image: image_path }

    return output unless owner?

    output.merge(
      destroy: destroy_path,
      update: update_path
    )
  end

  private

  def image_path
    return unless object.image.attached?

    rails_blob_path(object.image, only_path: true)
  end

  def owner?
    current_user &&
      object.user_id == current_user.id
  end

  def destroy_path
    path('destroy')
  end

  def update_path
    path('update')
  end

  def path(action)
    return unless object&.id

    url_for(controller: 'api/v1/adverts', action: action, id: object.id, only_path: true)
  end
end
