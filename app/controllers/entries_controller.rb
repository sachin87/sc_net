class EntriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @entries = @user.entries.order('created_at DESC').page(params[:page]).per(50)
    @usertemplate = @user.usertemplates.find_by_name('blog_index')
    if @usertemplate and @usertemplate.body.any?
      @page = Liquid::Template.parse(@usertemplate.body)
      render :text => @page.render({'user' => @user, 'entries' => @entries},
        [TextFilters])
    end
  end
  
  def show
    @entry = Entry.find_by_id_and_user_id(params[:id],params[:user_id],
      :include => [:user, [:comments => :user]])
    @comment = Comment.new
    @usertemplate = current_user.usertemplates.find_by_name('blog_entry')
    if @usertemplate and @usertemplate.body.any?
      @page = Liquid::Template.parse(@usertemplate.body)
      render :text => @page.render({'user' => @user,
          'entry' => @entry, 'comments' => @entry.comments},
        [TextFilters])
    end
  end
  
  def new
    @entry = Entry.new
  end
  
  def edit
    @entry = current_user.entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
  def create
    @entry = Entry.new(params[:entry])
    if current_user.entries << @entry
      flash[:notice] = 'Entry was successfully created.'
      redirect_to entry_path(:user_id => current_user,
        :id => @entry)
    else
      render :action => "new"
    end
  end
  
  def update
    @entry = current_user.entries.find(params[:id])
    if @entry.update_attributes(params[:entry])
      flash[:notice] = 'Entry was successfully updated.'
      redirect_to entry_path(current_user.id, @entry)
    else
      render :action => "edit"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to entries_path
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
end
