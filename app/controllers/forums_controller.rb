class ForumsController < ApplicationController

  def index
    @forums = Forum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  def show
    redirect_to forum_topics_path(:forum_id => params[:id])
  end
  
end
