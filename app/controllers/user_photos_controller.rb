class UserPhotosController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.order('created_at DESC').limit(5).
      offset(5).page(params[:page]).per(50)
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @photos.to_xml }
    end
  end
  
  def show
    @photo = Photo.find_by_user_id_and_id(params[:user_id],
      params[:id],
      :include => :user)
    if @photo.show_geo && (@photo.geo_lat && @photo.geo_long)
      @map = GMap.new("map_div_id")
      @map.control_init(:map_type => false, :small_zoom => true)
      @map.center_zoom_init([@photo.geo_lat, @photo.geo_long], 8)
      marker = GMarker.new([@photo.geo_lat, @photo.geo_long],
        :title => @photo.title,
        :info_window => @photo.body)
      @map.overlay_init(marker)
    end
    respond_to do |format|
      format.html # show.rhtml
      format.xml { render :xml => @photo.to_xml }
    end
  end


  def new
    @photo = current_user.photos.build
    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true)
    @map.center_zoom_init([25,0], 1)
    @map.record_init @map.on_click(
      "function (overlay, point) { updateLocation(point); }")
  end

  def edit
    @photo = current_user.photos.find(params[:id])

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true)
    if @photo.geo_lat && @photo.geo_long
      @map.center_zoom_init([@photo.geo_lat, @photo.geo_long], 8)
      marker = GMarker.new([@photo.geo_lat, @photo.geo_long],
        :title => @photo.title, :info_window => @photo.body)
      @map.overlay_init(marker)
    else
      @map.center_zoom_init([25,0], 1)
    end
    @map.record_init @map.on_click(
      "function (overlay, point) { updateLocation(point); }")

  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  def create
    @photo = current_user.photos.build(params[:photo])
    respond_to do |format|
      if @photo.save
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

  def add_tag
    @photo = current_user.photos.find(params[:id])
    @photo.tag_list += ',' + params[:tag][:name]
    @photo.save
    @new_tag = @photo.reload.tags.last
  end

  def remove_tag
    @photo = current_user.photos.find(params[:id])
    @tag_to_delete = @photo.tags.find(params[:tag_id])
    if @tag_to_delete
      @photo.tags.delete(@tag_to_delete)
    else
      render :nothing => true
    end
  end

end
