require 'helper'
require 'fakeweb'

class TestAccount < Test::Unit::TestCase
  def setup
    @account = TwitterAlert::Account.new :user_name => 'test_user', :password => 'test_password'

    FakeWeb.allow_net_connect = false
    FakeWeb.clean_registry
  end
  
  def test_followers
    FakeWeb.register_uri :get, 'http://test_user:test_password@twitter.com/followers/ids.json', :body => '[1, 2, 3]'

    assert_equal([1, 2, 3], @account.followers)
  end

  def test_announce
    FakeWeb.register_uri :get, 'http://test_user:test_password@twitter.com/followers/ids.json', :body => '[1, 2, 3]'
    FakeWeb.register_uri :post, 'http://test_user:test_password@twitter.com/direct_messages/new.json',
      :status => ['200', 'OK'],
      :body => '{"sender_id":12345678,"recipient_id":87654321,"text":"Test message."}'

    message = AlertTester.new 'Test message.', DateTime.now

    assert(@account.announce(message), "Announce returned false.")
    assert_equal([], @account.failed_announcements)

    # Should this even be here? I'm thinking no. Should be in TestAlert.
    assert(message.sent?, "Message not marked sent.")
  end

  def test_announce_failure
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

    message = AlertTester.new 'Test message.', DateTime.now
    @account.announce message

    assert_equal([{:follower_id => 2, :error_text => 'post http://twitter.com/direct_messages/new.json => 404: {"request":"/direct_messages/new.json","error":"Not found"}'}], @account.failed_announcements)
  end
end
