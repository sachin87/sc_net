class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.json
  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where(['forum_id = ?', @forum]).includes(:user).order('topics.updated_at DESC').page(params[:page]).per(50)
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @topics.to_xml }
    end
  end


  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    @post = Post.new
  end


  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
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



  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to posts_path(:topic_id => @topic,
            :forum_id => @topic.forum) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @topic.errors.to_xml }
      end
    end
  end


  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :ok }
    end
  end
end
