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

  test "extensions" do
    t = Ticket.new

    # check default values
    assert_equal "normal", t.priority
    assert !t.reported_by
    assert_equal "none", t.effects
    assert_equal "Sat", t.days
    assert !t.time

    # run validation and check attributes marked is_required
    assert !t.valid?
    assert_equal Extension.where(target_model: "Ticket", is_required: true).count + 2, t.errors.count

    # save ticket and read back - check values for each type of field
    t.title = "spell checker not working"
    t.description = "some common words are being flagged as incorrect by the spell checker"
    t.project_id = projects(:power_write)
    t.priority = "normal"
    t.tackled_by = "Amar"
    t.days = ["Mon", "Tue", "Fri"]
    assert t.save

    # edit a ticket, validations on that ticket should run
    t.title = "spell checker is too strict"
    t.tackled_by = ""
    assert !t.valid?
    assert [:handled_by] == t.errors.keys
    t.tackled_by = "Mohan"
    assert t.save

    # delete a ticket
    assert_no_difference 'Extension.count' do
      assert t.delete
    end
  end

  test "extended column labels can be changed without loss of data" do
    # store extended data with a ticket
    t = tickets(:ticket_1)
    t.priority = "normal"
    t.tackled_by = "Amar"
    t.days = ["Mon", "Tue"]
    assert t.save

    # change label
    e = extensions(:ticket_days)
    e.label = "Active days"
    assert e.save

    # data should still be there
    assert_equal ["Mon", "Tue"], t.days

    # validation error should use the new label
    t.days = []
    t.valid?
    assert !t.errors.keys.include?(:days)
    assert t.errors.keys.include?(:active_days)
  end
end
