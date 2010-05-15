module TwitterAlert

  # This represents the Twitter account you'll use to send DMs from.
  class Account

    # Config is a hash that needs :user_name and :password keys.
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

    # Sends the text of message to all of the account's followers. Message's class should include the TwitterAlert::Alert Module.
    #
    # Returns true if things went well and false if any DMs failed.
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

    # Returns an array of ids of all the followers of the account.
    def followers
      @client.followers.ids?
    end
  end
end
