require 'helper'

class TestAlert < Test::Unit::TestCase
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

  def test_failed_announcements
    @alert.add_failed_announcement 2, 'post http://twitter.com/direct_messages/new.json => 404: {"request":"/direct_messages/new.json","error":"Not found"}'
    assert_equal([{:follower_id => 2, :error_text => 'post http://twitter.com/direct_messages/new.json => 404: {"request":"/direct_messages/new.json","error":"Not found"}'}], @alert.failed_announcements)
  end

  def test_having_failed_announcements_blocks_being_marked_sent
    @alert.add_failed_announcement 2, 'post http://twitter.com/direct_messages/new.json => 404: {"request":"/direct_messages/new.json","error":"Not found"}'
    
    @alert.mark_sent
    assert(!@alert.sent?, "Alerts with failed announcements should not be able to be marked sent.")
  end
end
