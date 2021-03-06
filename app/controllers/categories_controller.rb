class CategoriesController < ApplicationController
    
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.xml { render :xml => @categories }
    end
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html { redirect_to category_articles_url(:category_id => @category) }
      format.xml { render :xml => @category }
    end
  end
  
end