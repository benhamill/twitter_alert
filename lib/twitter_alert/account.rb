require 'grackle'

class Account
  def initialize
    # Load hash from yaml file in default location.

    @username = config[:user_name]
    @password = config[:password]
  end

  def send message
    followers.each do |follower|
      @client.direct_messages.new! :user_id => follower, :text => message.text
    end

    message.mark_sent
  end

  def followers
    @client.followers.ids :screen_name => @user_name
  end
end
