require 'helper'

class TestAccount < Test::Unit::TestCase

  #Used for mocking HTTP requests
  class Net::HTTP
    class << self
      attr_accessor :response, :request, :last_instance, :responder
    end
    
    def connect
      # This needs to be overridden so SSL requests can be mocked
    end
   
    def request(req)
      self.class.last_instance = self
      if self.class.responder
        self.class.responder.call(self,req)        
      else
        self.class.request = req
        self.class.response
      end
    end
  end

  #Mock responses that conform to HTTPResponse's interface
  class MockResponse < Net::HTTPResponse
    #include Net::HTTPHeader
    attr_accessor :code, :body
    def initialize(code,body,headers={})
      super
      self.code = code
      self.body = body
      headers.each do |name, value|
        self[name] = value
      end
    end
  end
  
  #Transport that collects info on requests and responses for testing purposes
  class MockTransport < Grackle::Transport
    attr_accessor :status, :body, :method, :url, :options, :timeout
    
    def initialize(status,body,headers={})
      Net::HTTP.response = MockResponse.new(status,body,headers)
    end
    
    def request(method, string_url, options)
      self.method = method
      self.url = URI.parse(string_url)
      self.options = options
      super(method,string_url,options)
    end
  end

  class TwitterAlert::Account
    attr_accessor :client
  end

  def test_followers
    account = new_account(200, '[1, 2, 3]', {:user_name => 'test_user', :password => 'test_pass'})
    value = account.followers

    # Expect http://twitter.com/followers/ids.json?screen_name=test_user
    assert_equal :get, account.client.transport.method
    assert_equal 'http', account.client.transport.url.scheme
    assert_equal('twitter.com', account.client.transport.url.host)
    assert_equal('/followers/ids.json', account.client.transport.url.path)
    assert_equal [1, 2, 3], value
  end

  private

  def new_account(response_status, response_body, account_opts={})
    account = TwitterAlert::Account.new(account_opts)
    account.client.transport = MockTransport.new(response_status,response_body)
    account
  end
end
