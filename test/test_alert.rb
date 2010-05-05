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
    @account = TwitterAlert::Account.new :user_name => 'test_user', :password => 'test_password'

    FakeWeb.allow_net_connect = false
    FakeWeb.clean_registry

    FakeWeb.register_uri :get, 'http://test_user:test_password@twitter.com/followers/ids.json', :body => '[1, 2, 3]'
    FakeWeb.register_uri :post, 'http://test_user:test_password@twitter.com/direct_messages/new.json',
      [{
         :body => '{"sender_id":12345678,"recipient_id":87654321,"text":"Test message."}',
         :status => ['200', 'OK']
       }, {
         :body => '{"request":"/direct_messages/new.json","error":"Not found"}',
         :status => ['404', 'Not found']
       }, {
         :body => '{"sender_id":12345678,"recipient_id":87654321,"text":"Test message."}',
         :status => ['200', 'OK']
       }]

    @account.announce(@alert)

    assert_equal([{:follower_id => 2, :error_text => 'post http://twitter.com/direct_messages/new.json => 404: {"request":"/direct_messages/new.json","error":"Not found"}'}], @alert.failed_announcements)
  end
end
