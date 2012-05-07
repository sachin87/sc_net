class TopicsController < ApplicationController

  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where(['forum_id = ?', @forum]).includes(:user).order('topics.updated_at DESC').page(params[:page]).per(50)
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @topics.to_xml }
    end
  end

  def show
    redirect_to posts_path(:forum_id => params[:forum_id], :topic_id => params[:id])
  end

  def new
    @topic = Topic.new
    @post = Post.new
  end

  def create
    @topic = Topic.new(:name => params[:topic][:name],
      :forum_id => params[:forum_id],
      :user_id => logged_in_user.id)
    @topic.save!
    @post = Post.new(:body => params[:post][:body],
      :topic_id => @topic.id,
      :user_id => logged_in_user.id)
    @post.save!
    respond_to do |format|
      format.html { redirect_to posts_path(:topic_id => @topic,
          :forum_id => @topic.forum.id) }
      format.xml { head :created, :location => topic_path(:id => @topic,
          :forum_id => @topic.forum.id) }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml { render :xml => @post.errors.to_xml }
    end
  end

end
