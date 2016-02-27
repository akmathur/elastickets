class ProjectsController < ApplicationController
  def index
    @projects = Project.find :all
  
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @project = Project.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @project = Project.new
  
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def create
    @project = Project.new(params[:project])
  
    respond_to do |format|
      if @project.save
        flash[:success] = 'Project was successfully created.'
        format.html { redirect_to project_path(@project) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @project = Project.find(params[:id])
  
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated.'
        format.html { redirect_to projects_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  
    respond_to do |format|
      format.html { redirect_to(projects_path) }
    end
  end
end
