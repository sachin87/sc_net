class UsertemplatesController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @usertemplates = current_user.usertemplates.find(:all)
    if @usertemplates.empty?
      current_user.usertemplates << Usertemplate.new(:name => 'blog_index',:body => '')
      current_user.usertemplates << Usertemplate.new(:name => 'blog_entry',:body => '')
      @usertemplates = current_user.usertemplates.find(:all)
    end
  end

  def edit
    @usertemplate = current_user.usertemplates.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
  def update
    @usertemplate = current_user.usertemplates.find(params[:id])
    if @usertemplate.update_attributes(params[:usertemplate])
      flash[:notice] = 'Template was successfully updated.'
      redirect_to usertemplates_path
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
  
end