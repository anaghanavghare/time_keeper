class ProjectsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  def index
  	
  end

  # Required field are name, timeframe
  def create
  	@project = params[:project]
  	if @project.save
  		response_hash = {:projects_count => Project.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @project.errors.full_messages}
      render :json => response_hash, :status => :error
  	end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      response_hash = {:projects_count => Project.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @project.errors.full_messages}
      render :json => response_hash, :status => :error
    end
  end
end
