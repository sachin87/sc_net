class ArticlesController < ApplicationController

  def index
    if params[:category_id]
      @articles = Article.where("category_id= ? AND published=?",params[:category_id].to_i,true).include(:user).order('published_at DESC').page(params[:page]).per(50)
    else
      @articles = Article.where("published =?",true).include(:user).order('published_at DESC').page(params[:page]).per(50)
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
      format.xml { render :xml => @article.to_xml }
    end
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.create(params[:article])
    current_user.articles << @article
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml { render :xml => @article.to_xml }
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml { render :xml => @article.to_xml }
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml { render :nothing => true }
    end
  end

  def admin
    @articles = Article.order('published_at DESC')
  end

end