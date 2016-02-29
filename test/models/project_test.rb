require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "validations" do
    project = Project.new
    assert !project.valid?
    assert_equal 2, project.errors.messages.keys.count
    assert_equal 0, ([:name, :description] - project.errors.messages.keys).count

    project = Project.new(name: "muzicmania", description: "plays maniacal music like a magician")
    assert project.valid?
  end

  test "CRUD" do
    projects_count = Project.count

    # Create
    project = Project.new(name: "muzicmania", description: "plays maniacal music like a magician")
    assert project.save
    assert_equal projects_count+1, Project.count

    # Read
    assert "muzicmania", Project.where(name: "muzicmania").first.name

    # Update
    project.name = "Music-Mania"
    assert project.save
    assert_equal projects_count+1, Project.count

    # Delete
    assert project.delete
    assert projects_count, Project.count
  end
end
