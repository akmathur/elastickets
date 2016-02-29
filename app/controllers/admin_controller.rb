class AdminController < ApplicationController
  def index
    @projects = Project.all
  end
end
