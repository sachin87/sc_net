class ArticlesController < ApplicationController

  def index
    if params[:category_id]
      @articles = Article.includes(:user).published.in_category(params[:category_id].to_i).recents_first.page(params[:page]).per(50)
    else
      @articles = Article.includes(:user).published.recents_first.page(params[:page]).per(50)
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @articles }
      format.rss { render :layout => false }
      format.atom { render :layout => false }
    end
  end

  def show
    @article = Article.published.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @article }
    end
  end

end