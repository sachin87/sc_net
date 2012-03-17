class PhotosController < ApplicationController
  before_filter :authenticate_user!
  def index
    @photos = Photo.where(:conditions => 'thumbnail IS NULL').order('created_at DESC').
      limit(@photo_pages.items_per_page).offset(@photo_pages.current.offset).
      page(params[:page]).per(50)
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @photos.to_xml }
    end
  end

  def show
    @photo = Photo.find_by_user_id_and_id(params[:user_id],
      params[:id],
      :include => :user)
    respond_to do |format|
      format.html # show.rhtml
      format.xml { render :xml => @photo.to_xml }
    end
  end
  
  def new
    @photo = Photo.new
  end

  def edit
    @photo = current_user.photos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
  def create
    @photo = Photo.new(params[:photo])
    respond_to do |format|
      if current_user.photos << @photo
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(user_photos_path(:user_id=>current_user.id)) }
        format.xml { head :created,
          :location => user_photo_path(:user_id => @photo.user_id, :id => @photo)}
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @photo.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  
  def update
    @photo = current_user.photos.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to user_photo_path(:user_id => current_user,
            :id => @photo) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @photo.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to user_photos_path }
      format.xml { head :ok }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end


end
