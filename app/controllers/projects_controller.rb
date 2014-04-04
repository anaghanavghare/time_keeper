class ProjectsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  def index
  	@projects = Project.all
    respond_to do |format|
      format.html
      format.json{
        render :json => @projects.to_json
      }
    end
  end

  # Required field are name, timeframe
  def create
  	@project = params[:project]
  	if @project.save
      ProjectMailer.project_email(@project, current_user.email).deliver
  		@response_hash = {:projects_count => Project.count}
      @status = "ok"
    else
      @response_hash = {:errors => @project.errors.full_messages}
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
    @project = Project.find(params[:id])
    if @project
      @status = "ok"
    else
      @project = "Project not found"
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @project.to_json, :status => @status
      }
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      if @project.doc_name.changed?
        ProjectMailer.project_email(@project, current_user.email).deliver
      end
      @response_hash = {:projects_count => Project.count}
      @status = "ok"
    else
      @response_hash = {:errors => @project.errors.full_messages}
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
    @project = Project.find(params[:id])
    if @project and @project.destroy
      @status = "ok"
    else
      @project = "Project not found"
      @status = "error"
    end

    respond_to do |format|
      format.html
      format.json{
        render :json => @project.to_json, :status => @status
      }
    end
  end
end
