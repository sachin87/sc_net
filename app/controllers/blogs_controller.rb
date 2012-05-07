class BlogsController < ApplicationController

  def index
    @entries = Entry.order('entries.created_at DESC').
      includes(:user).page(params[:page]).per(50)
  end
  
end
