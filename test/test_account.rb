require 'helper'
require 'fakeweb'

FakeWeb.allow_net_connect = false

class TestAccount < Test::Unit::TestCase
  def setup
    @account = TwitterAlert::Account.new :user_name => 'test_user', :password => 'test_password'
  end
  
  def test_followers
    FakeWeb.register_uri :get, 'http://test_user:test_password@twitter.com/followers/ids.json', :body => '[1, 2, 3]'

    assert_equal([1, 2, 3], @account.followers)
  end

  def test_announce
    FakeWeb.register_uri :get, 'http://test_user:test_password@twitter.com/followers/ids.json', :body => '[1, 2, 3]'
    FakeWeb.register_uri :post, 'http://test_user:test_password@twitter.com/direct_messages/new.json', :body => 'DM sent.'

    message = AlertTester.new 'Test message.', DateTime.now

    assert(@account.announce(message), "Announce returned false.")
    assert(message.sent?, "Message not marked sent.")
    assert_equal([], @account.failed_announcements)
  end
end
