class PhotosController < ApplicationController
  def index
    @photos = Photo.where(:conditions => 'thumbnail IS NULL').order('created_at DESC').
      limit(@photo_pages.items_per_page).offset(@photo_pages.current.offset).
      page(params[:page]).per(50)
  end
end
