class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def show_by_username
    @user = User.find_by_username(params[:username])
    render 'show'
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to current_user
    else
      render :edit
    end
  end

end
