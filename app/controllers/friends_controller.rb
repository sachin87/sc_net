class FriendsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @user = User.find(params[:user_id], :include => [:friendships => :friend])
  end
  
  def show
    redirect_to user_path(params[:id])
  end

  def new
    @friend = User.find(params[:friend_id])
    unless current_user.friends.include?(@friend)
      @friendship = current_user.friendships.new(:friend_id => @friend.id)
    else
      redirect_to friend_path(:user_id => current_user, :id => @friend)
    end
  end

  def edit
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    @friend = @friendship.friend if @friendship
    if !@friendship
      redirect_to friend_path(:user_id => current_user, :id => params[:id])
    end
  end

  def create
    params[:friendship][:friend_id] = params[:friend_id]
    @friendship = current_user.friendships.create(params[:friendship])
    redirect_to friends_path(:user_id => current_user)
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def update
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    @friendship.update_attributes(params[:friendship])
    redirect_to friends_path(:user_id => current_user)
  rescue ActiveRecord::RecordInvalid
    render :action => 'edit'
  end
  
  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:id]).destroy
    redirect_to friends_path(:user_id => current_user)
  end

end
