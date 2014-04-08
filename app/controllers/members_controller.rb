class MembersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  load_and_authorize_resource :user, :parent => false
  #layout 'application'
  def index
  	@users = User.all.reject { |u|  u.id == 1}
    respond_to do |format|
      format.html
      format.json{
        render :json => @users.as_json
      }
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if @user
      @status = "ok"
    else
      @user = "User not found"
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @user.as_json, :status => @status
      }
    end
  end

  def create
  	@user = User.new(params[:user])
    @user.add_role(params[:user][:roles])
  	if @user.save
  		@response_hash = {:users_count => User.count}
      @status = "ok"
    else
      @response_hash = {:errors => @user.errors.full_messages}
      @status = "error"
  	end

    respond_to do |format|
      format.html
      format.json{
        render :json => @response_hash.to_json, :status => @status
      }
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user
      @status = "ok"
    else
      @user = "User not found"
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @user.as_json, :status => @status
      }
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_role(params[:user][:roles])
    if @user.update_attributes(params[:user])
      @response_hash = {:users_count => User.count}
      @status = "ok"
    else
      @response_hash = {:errors => @user.errors.full_messages}
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @response_hash.to_json, :status => @status
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user and @user.destroy
      @user = "User was delted succesfully."
      @status = "ok"
    else
      @user = "User not found"
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @user.as_json, :status => @status
      }
    end
  end
end
