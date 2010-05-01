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

  # def test_announce
  #   account = new_account(200, 'DM worked.', {:user_name => 'test_user', :password => 'test_pass'})

  #   def account.followers
  #     [1, 2]
  #   end

  #   message = AlertTester.new 'Test message.', DateTime.now

  #   account.announce message

  #   assert_equal(:post, account.client.transport.method)
  #   assert_equal('http', account.client.transport.url.scheme)
  #   assert_equal('twitter.com', account.client.transport.url.host)
  #   assert_equal('/direct_messages/new.json', account.client.transport.url.path)
  # end
end
