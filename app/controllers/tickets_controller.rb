class TicketsController < ApplicationController
  def index
    @tickets = Ticket.order("updated_at DESC").all
  
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @ticket = Ticket.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @ticket = Ticket.new
  
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
  
    respond_to do |format|
      if @ticket.save
        flash[:success] = 'Ticket was successfully created.'
        format.html { redirect_to tickets_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @ticket = Ticket.find(params[:id])
  
    respond_to do |format|
      if @ticket.update_attributes(ticket_params)
        flash[:success] = 'Ticket was successfully updated.'
        format.html { redirect_to tickets_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
  
    respond_to do |format|
      format.html { redirect_to(tickets_path) }
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:project_id, :title, :description, extended_attrs: Extension.permitted_params("Ticket"))
  end
end
