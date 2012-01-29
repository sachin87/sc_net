class BlogsController < ApplicationController
  def index
    @entries = Entry.limit(@entry_pages.items_per_page).
      offset(@entry_pages.current.offset).order('entries.created_at DESC').
      include(:user).page(params[:page]).per(50)
  end
end
