require 'helper'

class TestAlert < Test::Unit::TestCase
  class AlertTester
    include TwitterAlert::Alert
  end

  def setup
    @alert = AlertTester.new 'Test alert.', '01/02/2010'
  end

  def test_new
    assert_equal('Test alert.', @alert.text)
    assert_equal(DateTime.parse('01/02/2010'), @alert.date)
  end

  def test_new_alerts_are_marked_unsent
    assert(!@alert.sent?, "New Alerts shouldn't be marked sent.")
  end

  def test_alerts_can_be_marked_sent
    @alert.mark_sent
    assert(@alert.sent?, "Alerts should be able to be marked sent.")
  end
end
