class WelcomeController < ApplicationController
  def index
    @tickets = Ticket.all
    @projects = Project.all
  end
end
