class Admin::ExtensionsController < ApplicationController
  def index
    @extensions = Extension.find :all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @extension = Extension.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @extension = Extension.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @extension = Extension.find(params[:id])
  end

  def create
    @extension = Extension.new(extensions_params)

    respond_to do |format|
      if @extension.save
        flash[:success] = 'Extension was successfully created.'
        format.html { redirect_to admin_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @extension = Extension.find(params[:id])

    respond_to do |format|
      if @extension.update_attributes(extensions_params)
        flash[:success] = 'Extension was successfully updated.'
        format.html { redirect_to admin_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @extension = Extension.find(params[:id])
    @extension.destroy

    respond_to do |format|
      format.html { redirect_to(admin_path) }
    end
  end

  private

  def extensions_params
    params.require(:extension).permit(:target_model, :position, :label, :attr_name, :attr_type, :values, :default, :is_required)
  end
end
