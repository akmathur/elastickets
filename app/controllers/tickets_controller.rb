class TicketsController < ApplicationController
  def index
    @tickets = Ticket.find :all
  
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
    @ticket = Ticket.new(params[:ticket])
  
    respond_to do |format|
      if @ticket.save
        flash[:success] = 'Ticket was successfully created.'
        format.html { redirect_to ticket_path(@ticket) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @ticket = Ticket.find(params[:id])
  
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
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
end
