require 'helper'

class TestAlert < Test::Unit::TestCase
  class AlertTester
    include TwitterAlert::Alert
  end

  def test_new
    alert = AlertTester.new 'Test alert.', '01/02/2010'

    assert_equal('Test alert.', alert.text)
    assert_equal(DateTime.parse('01/02/2010'), alert.date)
  end
end
