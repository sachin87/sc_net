class PagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_page, :except => [:index,:new,:create]
  before_filter :check_administrator_role, :except => :show
  
  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
   if @page.save
    flash[:notice] = 'Page saved'
    redirect_to pages_path
  else
      render 'new'
   end
  end

  def edit
  end

  def update
    debugger
    if @page.update_attributes(params[:page])
     flash[:notice] = "Page updated"
     redirect_to pages_path
    else
     render 'edit'
    end
  end


  def destroy 
    if @page.destroy
      flash[:notice] = "Page deleted"
    else
      flash[:error] = "There was a problem deleting the page"
    end
    redirect_to :action => 'index'
  end

  private

  def find_page
    @page = Page.find(params[:id])
  end

end
