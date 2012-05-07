class PagesController < ApplicationController

  before_filter :authenticate_user!
  
  def show
    @page = Page.find(params[:id])
  end
  
end
