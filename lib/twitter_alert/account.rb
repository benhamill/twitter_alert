module TwitterAlert
  class Account
    def initialize config
      # Load hash from yaml file in default location?

      @username = config[:user_name]
      @password = config[:password]

      @client = Grackle::Client.new(
        :auth => {
          :type => :basic,
          :username => @username,
          :password => @password
        }
      )
    end

    def announce message
      followers.each do |follower|
        begin
          @client.direct_messages.new! :user_id => follower, :text => message.text
        rescue Grackle::TwitterError => e
          message.add_failed_announcement follower, e.message
        end
      end

      message.mark_sent
    end

    def followers
      @client.followers.ids?
    end
  end
end
