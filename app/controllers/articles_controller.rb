class ArticlesController < ApplicationController

  def index
    if params[:category_id]
      @articles = Article.includes(:user).where("articles.category_id= ? AND articles.published=?",params[:category_id].to_i,true).order('articles.published_at DESC').page(params[:page]).per(50)
    else
      @articles = Article.includes(:user).where("articles.published =?",true).order('articles.published_at DESC').page(params[:page]).per(50)
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @articles.to_xml }
      format.rss { render :action => 'rss.rxml', :layout => false }
      format.atom { render :action => 'atom.rxml', :layout => false }
    end
  end

  def show
    if current_user
      @article = Article.find(params[:id])
    else
      @article = Article.find_by_id_and_published(params[:id], true)
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @article }
    end
  end

  def new
    @article = current_user.articles.new
  end
  
  def create
    @article = current_user.articles.new(params[:article])
    if @rticle.save
      respond_to do |format|
        format.html { redirect_to admin_articles_url }
        format.xml { render :xml => @article }
      end
    end
  end
  
  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    @article.update_attributes(params[:article])
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml { render :xml => @article }
    end
  end
  
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml { render :nothing => true }
    end
  end

end