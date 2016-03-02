require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "validations" do
    ticket = Ticket.new
    assert !ticket.valid?
    assert_equal 5, ticket.errors.messages.keys.count
    assert_equal 0, ([:title, :description, :priority, :handled_by, :days] - ticket.errors.messages.keys).count

    ticket = Ticket.new(project_id: projects(:turbo_sheet).id,
                        title: "turbo sheet calculations are wrong",
                        description: "when I divide by zero I am getting something weird")
    assert !ticket.valid?

    ticket = Ticket.new(project_id: projects(:turbo_sheet).id,
                        title: "turbo sheet calculations are wrong",
                        description: "when I divide by zero I am getting something weird",
                        priority: "normal",
                        tackled_by: "Mohan",
                        days: "Mon")
    assert ticket.valid?
  end

  test "CRUD" do
    tickets_count = Ticket.count

    # Create
    ticket = Ticket.new(project_id: projects(:turbo_sheet).id,
                        title: "turbo sheet error",
                        description: "turbo sheet is crashing",
                        priority: "normal",
                        tackled_by: "Mohan",
                        days: "Mon")
    assert_difference 'Ticket.count' do
      ticket.save
    end

    # Read
    assert_equal ticket.project.name, projects(:turbo_sheet).name

    # Update
    assert_nothing_raised do
      ticket.update_attributes({title: "turbo sheet crashes",
                                 description: "crash happening while opening a large file"})
    end

    # Delete
    assert ticket.delete
    assert_equal tickets_count, Ticket.count
  end
end
