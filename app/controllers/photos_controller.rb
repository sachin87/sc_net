class PhotosController < ApplicationController
  before_filter :authenticate_user!

  def index
    @photos = Photo.order('created_at DESC').page(params[:page]).per(50)
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @photos.to_xml }
    end
  end

end
