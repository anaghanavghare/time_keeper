class ProjectsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  def index
  	@projects = Project.all
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

  def edit
    @project = Project.find(params[:id])
    if @project
      render :json => @project, :status => :ok
    else
      render :json => "Project not found", :status => :error
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

  def destroy
    @project = Project.find(params[:id])
    if @project and @project.destroy
      render :json => "Project was delted succesfully.", :status => :ok
    else
      render :json => "Project not found", :status => :error
    end
  end
end
