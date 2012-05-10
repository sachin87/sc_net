class TopicsController < ApplicationController

  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where(:forum => @forum).includes(:user).recents_first.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.xml { render :xml => @topics }
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
    @topic = current_user.topics.build(:name => params[:topic][:name], :forum_id => params[:forum_id])
    @topic.save!
    @post = current_user.posts.build(:body => params[:post][:body],:topic_id => @topic.id)
    @post.save!
    respond_to do |format|
      format.html { redirect_to posts_path(:topic_id => @topic, :forum_id => @topic.forum.id) }
      format.xml { head :created, :location => topic_path(:id => @topic,:forum_id => @topic.forum.id) }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml { render :xml => @post.errors.to_xml }
    end
  end

end
