require 'test_helper'

class ExtensionTest < ActiveSupport::TestCase
  test "validations" do
    e = Extension.new
    assert !e.valid?

    # default if specified should be one of the values
    assert !e.errors.keys.include?(:default)
    e.values = "a, b, c"
    e.valid?
    assert !e.errors.keys.include?(:default)
    e.default = "d"
    e.valid?
    assert e.errors.keys.include?(:default)
    e.default = "a"
    e.valid?
    assert !e.errors.keys.include?(:default)
  end

  test "values should be a comma separated list" do
    e = Extension.new
    e.values = "a,,b,c,  d, e,"
    assert_equal "a, b, c, d, e", e.values
  end

  test "permitted params" do
    assert_equal [{"effects"=>[]}, "tackled_by", {"days"=>[]}, "time", "priority", "reported_by", "full_scenario"], Extension.permitted_params("Ticket")
  end
end
