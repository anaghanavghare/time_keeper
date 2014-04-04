class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  #layout 'application'
  def index
  	@users = User.all.reject { |u|  u.id == 1}
    render :json => @users, :status => :ok
  end

  def create
  	@user = params[:user]
    @user.add_role(params[:user][:role])
  	if @user.save
  		response_hash = {:users_count => User.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @user.errors.full_messages}
      render :json => response_hash, :status => :error
  	end
  end

  def edit
    @user = User.find(params[:id])
    if @user
      render :json => @user, :status => :ok
    else
      render :json => "User not found", :status => :error
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_role(params[:user][:role])
    if @user.update_attributes(params[:user])
      response_hash = {:users_count => User.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @user.errors.full_messages}
      render :json => response_hash, :status => :error
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user and @user.destroy
      render :json => "User was delted succesfully.", :status => :ok
    else
      render :json => "User not found", :status => :error
    end
  end
end
