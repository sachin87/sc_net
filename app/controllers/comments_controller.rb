class CommentsController < ApplicationController

  before_filter :authenticate_user!
  
  def create
    @entry = Entry.find_by_user_id_and_id(params[:user_id],params[:entry_id])
    @comment = Comment.new(:user => current_user,:body => params[:comment][:body])
    if @entry.comments << @comment
      flash[:notice] = 'Comment was successfully created.'
      redirect_to entries_path(:user_id => @entry.user,
        :entry_id => @entry)
    else
      render :controller => 'entries', :action => 'show',
        :user_id => @entry.user, :entry_id => @entry
    end
  end
  
  def destroy
    @entry = Entry.find_by_user_id_and_id(current_user.id,params[:entry_id],:include => :user)
    @comment = @entry.comments.find(params[:id])
    @comment.destroy
    redirect_to entry_path(:user_id => @entry.user.id,
      :id => @entry.id)
  end
  
end
